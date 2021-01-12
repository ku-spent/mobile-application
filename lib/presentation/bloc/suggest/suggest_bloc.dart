import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:spent/domain/model/News.dart';
import 'package:spent/domain/use_case/get_news_feed_use_case.dart';
import 'package:rxdart/rxdart.dart';
import 'package:spent/presentation/bloc/network/network_bloc.dart';

part 'suggest_event.dart';
part 'suggest_state.dart';

@injectable
class SuggestFeedBloc extends Bloc<SuggestFeedEvent, SuggestFeedState> {
  final int fetchSize = 10;
  final GetNewsFeedUseCase _getNewsFeedUseCase;
  final NetworkBloc _networkBloc;

  String query;
  String queryField;

  SuggestFeedBloc(this._getNewsFeedUseCase, this._networkBloc) : super(SuggestFeedInitial());

  @override
  Stream<SuggestFeedState> mapEventToState(
    SuggestFeedEvent event,
  ) async* {
    if (event is InitialSuggestFeed) {
      query = event.query;
      queryField = event.queryField;
      yield* _mapInitialLoadedSuggestFeedState();
    } else if ((event is FetchSuggestFeed && __hasMore(state))) {
      yield* _mapLoadedSuggestFeedState();
    } else if (event is RefreshSuggestFeed) {
      yield* _mapRefreshLoadedSuggestFeedState(event.callback);
    }
  }

  bool __hasMore(SuggestFeedState state) => state is SuggestFeedLoaded && state.hasMore;

  Stream<SuggestFeedState> _mapInitialLoadedSuggestFeedState() async* {
    // yield SuggestFeedLoading();
    try {
      final feeds = await _getNewsFeedUseCase.call(
        from: 0,
        size: fetchSize,
        query: query,
        queryField: queryField,
        isRemote: _networkBloc.isConnected,
      );
      final hasMore = feeds.length >= fetchSize;
      yield SuggestFeedLoaded(feeds: feeds, hasMore: hasMore, query: query);
    } catch (_) {
      yield SuggestFeedError();
    }
  }

  Stream<SuggestFeedState> _mapLoadedSuggestFeedState() async* {
    try {
      final curState = state;
      if (curState is SuggestFeedLoaded) {
        final feeds = await _getNewsFeedUseCase.call(
          from: curState.feeds.length,
          size: fetchSize,
          query: query,
          queryField: queryField,
          isRemote: _networkBloc.isConnected,
        );
        yield feeds.isEmpty
            ? curState.copyWith(hasMore: false)
            : SuggestFeedLoaded(feeds: curState.feeds + feeds, hasMore: true, query: query);
      }
    } catch (_) {
      yield SuggestFeedError();
    }
  }

  Stream<SuggestFeedState> _mapRefreshLoadedSuggestFeedState(RefreshFeedCallback callback) async* {
    try {
      final curState = state;
      if (curState is SuggestFeedError) {
        // yield SuggestFeedLoading();
      }
      final feeds = await _getNewsFeedUseCase.call(from: 0, size: fetchSize, query: query, queryField: queryField);
      yield SuggestFeedLoaded(feeds: feeds, hasMore: true, query: query);
      if (callback != null) callback();
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
