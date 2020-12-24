import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:injectable/injectable.dart';
import 'package:spent/domain/model/News.dart';
import 'package:spent/domain/use_case/get_news_feed_use_case.dart';
import 'package:rxdart/rxdart.dart';
import 'package:spent/presentation/bloc/network/network_bloc.dart';

part 'feed_event.dart';
part 'feed_state.dart';

@injectable
class FeedBloc extends Bloc<FeedEvent, FeedState> {
  final int fetchSize = 10;
  final GetNewsFeedUseCase _getNewsFeedUseCase;
  final NetworkBloc _networkBloc;

  FeedBloc(this._getNewsFeedUseCase, this._networkBloc) : super(FeedInitial());

  @override
  Stream<FeedState> mapEventToState(
    FeedEvent event,
  ) async* {
    if (event is FetchFeed && (__hasMore(state) || state is FeedInitial)) {
      yield* _mapLoadedFeedState(event);
    } else if (event is RefreshFeed) {
      yield* _mapRefreshLoadedFeedState(event.callback);
    }
  }

  bool __hasMore(FeedState state) => state is FeedLoaded && state.hasMore;

  Stream<FeedState> _mapLoadedFeedState(FeedEvent event) async* {
    try {
      final curState = state;
      if (curState is FeedInitial) {
        final feeds = await _getNewsFeedUseCase.call(
          from: 0,
          size: fetchSize,
          isRemote: _networkBloc.isConnected,
        );
        yield FeedLoaded(feeds: feeds, hasMore: true);
      } else if (curState is FeedLoaded) {
        final feeds = await _getNewsFeedUseCase.call(
          from: curState.feeds.length,
          size: fetchSize,
          isRemote: _networkBloc.isConnected,
        );
        yield feeds.isEmpty
            ? curState.copyWith(hasMore: false)
            : FeedLoaded(feeds: curState.feeds + feeds, hasMore: true);
      }
    } catch (e) {
      print(e);
      yield FeedError();
    }
  }

  Stream<FeedState> _mapRefreshLoadedFeedState(RefreshFeedCallback callback) async* {
    try {
      final curState = state;
      if (curState is FeedError) {
        yield FeedLoading();
      }
      if (curState is FeedLoaded) {
        final feeds = await _getNewsFeedUseCase.call(
          from: 0,
          size: fetchSize,
          isRemote: _networkBloc.isConnected,
        );
        yield FeedLoaded(feeds: feeds, hasMore: true);
      }
      if (callback != null) callback();
    } catch (_) {
      yield FeedError();
    }
  }

  @override
  Stream<Transition<FeedEvent, FeedState>> transformEvents(Stream<FeedEvent> events, transitionFn) {
    return super.transformEvents(events.debounceTime(const Duration(milliseconds: 500)), transitionFn);
  }
}
