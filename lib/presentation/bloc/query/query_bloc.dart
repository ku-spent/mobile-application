import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:spent/domain/model/News.dart';
import 'package:spent/domain/use_case/get_news_feed_trend_use_case.dart';
import 'package:spent/domain/use_case/get_news_feed_use_case.dart';
import 'package:rxdart/rxdart.dart';
import 'package:spent/presentation/bloc/network/network_bloc.dart';

part 'query_event.dart';
part 'query_state.dart';

@injectable
class QueryFeedBloc extends Bloc<QueryFeedEvent, QueryFeedState> {
  final int fetchSize = 10;
  final NetworkBloc _networkBloc;
  final GetNewsFeedTrendUseCase _getNewsFeedTrendUseCase;
  final GetNewsFeedUseCase _getNewsFeedUseCase;

  QueryObject query;

  QueryFeedBloc(this._getNewsFeedUseCase, this._getNewsFeedTrendUseCase, this._networkBloc) : super(QueryFeedInitial());

  @override
  Stream<QueryFeedState> mapEventToState(
    QueryFeedEvent event,
  ) async* {
    if (event is InitialQueryFeed) {
      yield* _mapInitialLoadedQueryFeedState(event);
    } else if ((event is FetchQueryFeed && __hasMore(state))) {
      yield* _mapLoadedQueryFeedState();
    } else if (event is RefreshQueryFeed) {
      yield* _mapRefreshLoadedQueryFeedState(event.callback);
    }
  }

  bool __hasMore(QueryFeedState state) => state is QueryFeedLoaded && state.hasMore;

  Stream<QueryFeedState> _mapInitialLoadedQueryFeedState(InitialQueryFeed event) async* {
    query = event.query;
    final _curQuery = event.query;
    try {
      List<News> feeds = [];
      if (_curQuery is QueryWithField) {
        feeds = await _getNewsFeedUseCase.call(
          from: 0,
          size: fetchSize,
          query: _curQuery.query,
          queryField: _curQuery.queryField,
          isRemote: _networkBloc.isConnected,
        );
      } else if (_curQuery is QueryWithTrend) {
        feeds = await _getNewsFeedTrendUseCase.call(
          trend: _curQuery.trend,
          from: 0,
          size: fetchSize,
          isRemote: _networkBloc.isConnected,
        );
      }
      final hasMore = feeds.length >= fetchSize;
      yield QueryFeedLoaded(feeds: feeds, hasMore: hasMore, query: _curQuery);
    } catch (_) {
      yield QueryFeedError(query);
    }
  }

  Stream<QueryFeedState> _mapLoadedQueryFeedState() async* {
    try {
      final curState = state;
      if (curState is QueryFeedLoaded) {
        final _curQuery = curState.query;
        List<News> feeds = [];
        if (_curQuery is QueryWithField) {
          feeds = await _getNewsFeedUseCase.call(
            from: curState.feeds.length,
            size: fetchSize,
            query: _curQuery.query,
            queryField: _curQuery.queryField,
            isRemote: _networkBloc.isConnected,
          );
        } else if (_curQuery is QueryWithTrend) {
          feeds = await _getNewsFeedTrendUseCase.call(
            trend: _curQuery.trend,
            from: curState.feeds.length,
            size: fetchSize,
            isRemote: _networkBloc.isConnected,
          );
        }
        yield feeds.isEmpty
            ? curState.copyWith(hasMore: false)
            : QueryFeedLoaded(feeds: curState.feeds + feeds, hasMore: true, query: _curQuery);
      }
    } catch (_) {
      yield QueryFeedError(query);
    }
  }

  Stream<QueryFeedState> _mapRefreshLoadedQueryFeedState(RefreshFeedCallback callback) async* {
    try {
      final curState = state;
      if (curState is QueryFeedError) {
        yield QueryFeedLoading();
      }
      if (curState is QueryFeedLoaded) {
        List<News> feeds = [];
        final _curQuery = curState.query;
        if (_curQuery is QueryWithField) {
          feeds = await _getNewsFeedUseCase.call(
            from: 0,
            size: fetchSize,
            query: _curQuery.query,
            queryField: _curQuery.queryField,
          );
        } else if (_curQuery is QueryWithTrend) {
          feeds = await _getNewsFeedTrendUseCase.call(
            trend: _curQuery.trend,
            from: 0,
            size: fetchSize,
            isRemote: _networkBloc.isConnected,
          );
        }
        yield QueryFeedLoaded(feeds: feeds, hasMore: true, query: query);
      }
      if (callback != null) callback();
    } catch (_) {
      yield QueryFeedError(query);
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
  static const String tags = 'tags';
}

class QueryObject extends Equatable {
  final String title;

  const QueryObject(this.title);

  @override
  List<Object> get props => [];
}

class QueryWithField extends QueryObject {
  final String query;
  final String queryField;

  QueryWithField(String title, {@required this.query, @required this.queryField}) : super(title);

  @override
  List<Object> get props => [query, queryField];
}

class QueryWithTrend extends QueryObject {
  final String trend;

  QueryWithTrend(String title, {@required this.trend}) : super(title);

  @override
  List<Object> get props => [trend];
}
