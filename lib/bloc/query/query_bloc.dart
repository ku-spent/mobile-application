import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:spent/model/news.dart';
import 'package:spent/repository/feed_repository.dart';
import 'package:rxdart/rxdart.dart';

part 'query_event.dart';
part 'query_state.dart';

class QueryFeed extends Bloc<QueryFeedEvent, QueryFeedState> {
  String query;
  String queryField;
  final int fetchSize = 10;
  final FeedRepository feedRepository;

  QueryFeed({@required this.feedRepository}) : super(QueryFeedInitial());

  @override
  Stream<QueryFeedState> mapEventToState(
    QueryFeedEvent event,
  ) async* {
    if (event is InitialQueryFeed) {
      query = event.query;
      queryField = event.queryField;
      yield* _mapInitialLoadedQueryFeedState();
    } else if ((event is FetchQueryFeed && __hasMore(state))) {
      yield* _mapLoadedQueryFeedState();
    } else if (event is RefreshQueryFeed) {
      yield* _mapRefreshLoadedQueryFeedState(event.callback);
    }
  }

  bool __hasMore(QueryFeedState state) =>
      state is QueryFeedLoaded && state.hasMore;

  Stream<QueryFeedState> _mapInitialLoadedQueryFeedState() async* {
    try {
      final feeds = await feedRepository.fetchFeeds(
          from: 0, size: fetchSize, query: query, queryField: queryField);
      final hasMore = feeds.length >= fetchSize;
      yield QueryFeedLoaded(feeds: feeds, hasMore: hasMore);
    } catch (_) {
      yield QueryFeedError();
    }
  }

  Stream<QueryFeedState> _mapLoadedQueryFeedState() async* {
    try {
      final curState = state;
      if (curState is QueryFeedLoaded) {
        final feeds = await feedRepository.fetchFeeds(
            from: curState.feeds.length,
            size: fetchSize,
            query: query,
            queryField: queryField);
        yield feeds.isEmpty
            ? curState.copyWith(hasMore: false)
            : QueryFeedLoaded(feeds: curState.feeds + feeds, hasMore: true);
      }
    } catch (_) {
      yield QueryFeedError();
    }
  }

  Stream<QueryFeedState> _mapRefreshLoadedQueryFeedState(
      RefreshFeedCallback callback) async* {
    try {
      final curState = state;
      if (curState is QueryFeedLoaded) {
        final feeds = await feedRepository.fetchFeeds(
            from: 0, size: fetchSize, query: query, queryField: queryField);
        yield QueryFeedLoaded(feeds: feeds, hasMore: true);
      }
      if (callback != null) callback();
    } catch (_) {
      yield QueryFeedError();
    }
  }

  @override
  Stream<Transition<QueryFeedEvent, QueryFeedState>> transformEvents(
      Stream<QueryFeedEvent> events, transitionFn) {
    return super.transformEvents(
        events.debounceTime(const Duration(milliseconds: 500)), transitionFn);
  }
}

class QueryField {
  static const String source = 'source';
  static const String category = 'category';
}
