import 'dart:async';

import 'package:rxdart/rxdart.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:spent/domain/model/News.dart';
import 'package:spent/domain/use_case/get_view_news_history_use_case.dart';

part 'history_event.dart';
part 'history_state.dart';

@singleton
class HistoryBloc extends Bloc<HistoryEvent, HistoryState> {
  final int fetchSize = 10;
  final GetViewNewsHistoryUseCase _getViewNewsHistoryUseCase;

  HistoryBloc(this._getViewNewsHistoryUseCase) : super(HistoryInitial());

  bool _hasMore(HistoryState state) => state is HistoryLoaded && state.hasMore;

  @override
  Stream<HistoryState> mapEventToState(
    HistoryEvent event,
  ) async* {
    if (event is FetchHistory) {
      yield* _mapHistoryLoadedState(event);
    } else if (event is RefreshHistory) {
      yield* _mapRefreshHistoryLoadedState(event);
    } else if (event is RemoveHistoryFromList) {
      yield* _mapRemoveHistoryFromListState(event);
    }
  }

  Stream<HistoryState> _mapHistoryLoadedState(FetchHistory event) async* {
    try {
      final curState = state;
      if (curState is HistoryInitial) {
        // yield HistoryLoading();
        final List<News> newsHistories = await _getViewNewsHistoryUseCase.call(query: '', from: 0, size: fetchSize);
        yield HistoryLoaded(news: newsHistories, hasMore: newsHistories.length == fetchSize);
      } else if (curState is HistoryLoaded) {
        final List<News> newsHistories =
            await _getViewNewsHistoryUseCase.call(query: event.query, from: curState.news.length, size: fetchSize);
        yield newsHistories.isEmpty
            ? curState.copyWith(hasMore: false)
            : HistoryLoaded(news: curState.news + newsHistories, hasMore: true);
      }
    } catch (e) {
      print(e);
      yield HistoryLoadError();
    }
  }

  Stream<HistoryState> _mapRefreshHistoryLoadedState(RefreshHistory event) async* {
    try {
      final List<News> newsHistories =
          await _getViewNewsHistoryUseCase.call(query: event.query, from: 0, size: fetchSize);
      yield HistoryLoaded(news: newsHistories, hasMore: newsHistories.length == fetchSize);
    } catch (e) {
      print(e);
      yield HistoryLoadError();
    } finally {
      if (event.callback != null) {
        event.callback();
      }
    }
  }

  Stream<HistoryState> _mapRemoveHistoryFromListState(RemoveHistoryFromList event) async* {
    try {
      final curState = state;
      if (curState is HistoryLoaded) {
        yield curState.copyWith(
          news: curState.news.where((element) => element.id != event.news.id).toList(),
          hasMore: curState.hasMore,
        );
      }
    } catch (e) {
      print(e);
      yield HistoryLoadError();
    }
  }

  @override
  Stream<Transition<HistoryEvent, HistoryState>> transformEvents(Stream<HistoryEvent> events, transitionFn) {
    return super.transformEvents(events.debounceTime(const Duration(milliseconds: 500)), transitionFn);
  }
}
