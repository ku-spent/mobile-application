import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:spent/domain/model/News.dart';
import 'package:spent/domain/use_case/get_news_feed_use_case.dart';
import 'package:rxdart/rxdart.dart';
import 'package:spent/presentation/bloc/network/network_bloc.dart';

part 'query_event.dart';
part 'query_state.dart';

@injectable
class QueryFeedBloc extends Bloc<QueryFeedEvent, QueryFeedState> {
  final int fetchSize = 10;
  final GetNewsFeedUseCase _getNewsFeedUseCase;
  final NetworkBloc _networkBloc;

  String query;
  String queryField;

  QueryFeedBloc(this._getNewsFeedUseCase, this._networkBloc) : super(QueryFeedInitial());

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

  bool __hasMore(QueryFeedState state) => state is QueryFeedLoaded && state.hasMore;

  Stream<QueryFeedState> _mapInitialLoadedQueryFeedState() async* {
    try {
      final feeds = await _getNewsFeedUseCase.call(
        from: 0,
        size: fetchSize,
        query: query,
        queryField: queryField,
        isRemote: _networkBloc.isConnected,
      );
      final hasMore = feeds.length >= fetchSize;
      yield QueryFeedLoaded(feeds: feeds, hasMore: hasMore, query: query);
    } catch (_) {
      yield QueryFeedError();
    }
  }

  Stream<QueryFeedState> _mapLoadedQueryFeedState() async* {
    try {
      final curState = state;
      if (curState is QueryFeedLoaded) {
        final feeds = await _getNewsFeedUseCase.call(
          from: curState.feeds.length,
          size: fetchSize,
          query: query,
          queryField: queryField,
          isRemote: _networkBloc.isConnected,
        );
        yield feeds.isEmpty
            ? curState.copyWith(hasMore: false)
            : QueryFeedLoaded(feeds: curState.feeds + feeds, hasMore: true, query: query);
      }
    } catch (_) {
      yield QueryFeedError();
    }
  }

  Stream<QueryFeedState> _mapRefreshLoadedQueryFeedState(RefreshFeedCallback callback) async* {
    try {
      final curState = state;
      if (curState is QueryFeedLoaded) {
        final feeds = await _getNewsFeedUseCase.call(from: 0, size: fetchSize, query: query, queryField: queryField);
        yield QueryFeedLoaded(feeds: feeds, hasMore: true, query: query);
      }
      if (callback != null) callback();
    } catch (_) {
      yield QueryFeedError();
    }
  }

  @override
  Stream<Transition<QueryFeedEvent, QueryFeedState>> transformEvents(Stream<QueryFeedEvent> events, transitionFn) {
    return super.transformEvents(events.debounceTime(const Duration(milliseconds: 500)), transitionFn);
  }
}

class QueryField {
  static const String source = 'source';
  static const String category = 'category';
}
