import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:spent/domain/model/News.dart';
import 'package:spent/domain/use_case/get_view_news_history_use_case.dart';

part 'history_event.dart';
part 'history_state.dart';

@singleton
class HistoryBloc extends Bloc<HistoryEvent, HistoryState> {
  final GetViewNewsHistoryUseCase _getViewNewsHistoryUseCase;

  HistoryBloc(this._getViewNewsHistoryUseCase) : super(HistoryInitial());

  @override
  Stream<HistoryState> mapEventToState(
    HistoryEvent event,
  ) async* {
    if (event is FetchHistory) {
      yield* _mapHistoryLoadedState(event);
    }
  }

  Stream<HistoryState> _mapHistoryLoadedState(FetchHistory event) async* {
    yield HistoryLoading();
    try {
      List<News> newsHistories = await _getViewNewsHistoryUseCase.call();
      yield HistoryLoaded(newsHistories);
    } catch (e) {
      print(e);
      yield HistoryLoadError();
    }
  }
}
