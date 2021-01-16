import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:spent/domain/model/News.dart';
import 'package:rxdart/rxdart.dart';
import 'package:spent/domain/use_case/get_suggestion_use_case.dart';
import 'package:spent/presentation/bloc/network/network_bloc.dart';

part 'suggest_event.dart';
part 'suggest_state.dart';

@injectable
class SuggestFeedBloc extends Bloc<SuggestFeedEvent, SuggestFeedState> {
  final int fetchSize = 10;
  final GetSuggestionNewsUseCase _getSuggestionNewsUseCase;
  final NetworkBloc _networkBloc;

  SuggestFeedBloc(this._getSuggestionNewsUseCase, this._networkBloc) : super(SuggestFeedInitial());

  @override
  Stream<SuggestFeedState> mapEventToState(
    SuggestFeedEvent event,
  ) async* {
    if (event is InitialSuggestFeed) {
      yield* _mapInitialLoadedSuggestFeedState(event);
    } else if ((event is FetchSuggestFeed && __hasMore(state))) {
      yield* _mapLoadedSuggestFeedState();
    }
  }

  bool __hasMore(SuggestFeedState state) => state is SuggestFeedLoaded && state.hasMore;

  Stream<SuggestFeedState> _mapInitialLoadedSuggestFeedState(InitialSuggestFeed event) async* {
    // yield SuggestFeedLoading();
    final News curNews = event.curNews;
    try {
      final feeds = await _getSuggestionNewsUseCase.call(
        from: 0,
        size: fetchSize,
        curNews: curNews,
        isRemote: _networkBloc.isConnected,
      );
      final hasMore = feeds.length >= fetchSize;
      yield SuggestFeedLoaded(feeds: feeds, hasMore: hasMore, curNews: curNews);
    } catch (_) {
      yield SuggestFeedError();
    }
  }

  Stream<SuggestFeedState> _mapLoadedSuggestFeedState() async* {
    try {
      final curState = state;
      if (curState is SuggestFeedLoaded) {
        final News curNews = curState.curNews;
        final feeds = await _getSuggestionNewsUseCase.call(
          from: curState.feeds.length,
          size: fetchSize,
          curNews: curState.curNews,
          isRemote: _networkBloc.isConnected,
        );
        yield feeds.isEmpty
            ? curState.copyWith(hasMore: false)
            : SuggestFeedLoaded(feeds: curState.feeds + feeds, hasMore: true, curNews: curNews);
      }
    } catch (_) {
      yield SuggestFeedError();
    }
  }

  @override
  Stream<Transition<SuggestFeedEvent, SuggestFeedState>> transformEvents(
      Stream<SuggestFeedEvent> events, transitionFn) {
    return super.transformEvents(events.debounceTime(const Duration(milliseconds: 500)), transitionFn);
  }
}

class SuggestField {
  static const String source = 'source';
  static const String category = 'category';
}
