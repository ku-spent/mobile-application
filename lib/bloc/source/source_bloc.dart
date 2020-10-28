import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:spent/model/news.dart';
import 'package:spent/repository/feed_repository.dart';
import 'package:rxdart/rxdart.dart';

part 'source_event.dart';
part 'source_state.dart';

class SourceBloc extends Bloc<SourceEvent, SourceState> {
  String source;
  final int fetchSize = 5;
  final FeedRepository feedRepository;

  SourceBloc({@required this.feedRepository}) : super(SourceInitial());

  @override
  Stream<SourceState> mapEventToState(
    SourceEvent event,
  ) async* {
    if (event is InitialSource) {
      source = event.source;
      yield* _mapInitialLoadedSourceState();
    } else if ((event is FetchSource &&
        (__hasMore(state) || state is SourceInitial))) {
      yield* _mapLoadedSourceState();
    } else if (event is RefreshSource) {
      yield* _mapRefreshLoadedSourceState(event.callback);
    }
  }

  bool __hasMore(SourceState state) => state is SourceLoaded && state.hasMore;

  Stream<SourceState> _mapInitialLoadedSourceState() async* {
    try {
      final feeds = await feedRepository.fetchFeeds(
          from: 0, size: fetchSize, source: source);
      yield SourceLoaded(feeds: feeds, hasMore: true);
    } catch (_) {
      yield SourceError();
    }
  }

  Stream<SourceState> _mapLoadedSourceState() async* {
    try {
      final curState = state;
      if (curState is SourceInitial) {
        final feeds = await feedRepository.fetchFeeds(
            from: 0, size: fetchSize, source: source);
        yield SourceLoaded(feeds: feeds, hasMore: true);
      } else if (curState is SourceLoaded) {
        final feeds = await feedRepository.fetchFeeds(
            from: curState.feeds.length, size: fetchSize, source: source);
        yield feeds.isEmpty
            ? curState.copyWith(hasMore: false)
            : SourceLoaded(feeds: curState.feeds + feeds, hasMore: true);
      }
    } catch (_) {
      yield SourceError();
    }
  }

  Stream<SourceState> _mapRefreshLoadedSourceState(
      RefreshFeedCallback callback) async* {
    try {
      final curState = state;
      if (curState is SourceLoaded) {
        final feeds = await feedRepository.fetchFeeds(
            from: 0, size: fetchSize, source: source);
        yield SourceLoaded(feeds: feeds, hasMore: true);
      }
      if (callback != null) callback();
    } catch (_) {
      yield SourceError();
    }
  }

  @override
  Stream<Transition<SourceEvent, SourceState>> transformEvents(
      Stream<SourceEvent> events, transitionFn) {
    return super.transformEvents(
        events.debounceTime(const Duration(milliseconds: 500)), transitionFn);
  }
}
