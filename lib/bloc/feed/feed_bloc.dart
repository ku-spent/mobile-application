import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:spent/model/news.dart';
import 'package:spent/repository/feed_repository.dart';
import 'package:rxdart/rxdart.dart';

part 'feed_event.dart';
part 'feed_state.dart';

class FeedBloc extends Bloc<FeedEvent, FeedState> {
  final int fetchSize = 5;
  final FeedRepository feedRepository;

  FeedBloc({@required this.feedRepository}) : super(FeedInitial());

  @override
  Stream<FeedState> mapEventToState(
    FeedEvent event,
  ) async* {
    if (state is FeedInitial || (event is FetchFeed && __hasMore(state))) {
      yield* _mapLoadedFeedState();
    } else if (event is RefreshFeed) {
      yield* _mapRefreshLoadedFeedState(event.callback);
    }
  }

  bool __hasMore(FeedState state) => state is FeedLoaded && state.hasMore;

  Stream<FeedState> _mapLoadedFeedState() async* {
    try {
      final curState = state;
      if (curState is FeedInitial) {
        final feeds = await feedRepository.fetchFeeds(from: 0, size: fetchSize);
        yield FeedLoaded(feeds: feeds, hasMore: true);
      } else if (curState is FeedLoaded) {
        final feeds = await feedRepository.fetchFeeds(
            from: curState.feeds.length, size: fetchSize);
        yield news.isEmpty
            ? curState.copyWith(hasMore: false)
            : FeedLoaded(feeds: curState.feeds + feeds, hasMore: true);
      }
    } catch (_) {
      yield FeedError();
    }
  }

  Stream<FeedState> _mapRefreshLoadedFeedState(
      RefreshFeedCallback callback) async* {
    try {
      final curState = state;
      if (curState is FeedLoaded) {
        final feeds = await feedRepository.fetchFeeds(from: 0, size: fetchSize);
        yield FeedLoaded(feeds: feeds, hasMore: true);
      }
      if (callback != null) callback();
    } catch (_) {
      yield FeedError();
    }
  }

  @override
  Stream<Transition<FeedEvent, FeedState>> transformEvents(
      Stream<FeedEvent> events, transitionFn) {
    // TODO: implement transformEvents
    return super.transformEvents(
        events.debounceTime(const Duration(milliseconds: 500)), transitionFn);
  }
}
