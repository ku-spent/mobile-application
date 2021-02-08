import 'dart:async';

import 'package:rxdart/rxdart.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:spent/domain/model/trending.dart';
import 'package:spent/domain/use_case/get_explore_use_case.dart';

part 'explore_event.dart';
part 'explore_state.dart';

@injectable
class ExploreBloc extends Bloc<ExploreEvent, ExploreState> {
  final int fetchSize = 5;
  final GetExploreUseCase _getExploreUseCase;

  ExploreBloc(this._getExploreUseCase) : super(ExploreInitial());

  @override
  Stream<ExploreState> mapEventToState(
    ExploreEvent event,
  ) async* {
    if (event is FetchExplore && (__hasMore(state) || state is ExploreInitial)) {
      yield* _mapLoadedExploreState(event);
    } else if (event is RefreshExplore) {
      yield* _mapRefreshLoadedExploreState(event.callback);
    }
  }

  bool __hasMore(ExploreState state) => state is ExploreLoaded && state.hasMore;

  Stream<ExploreState> _mapLoadedExploreState(ExploreEvent event) async* {
    try {
      final curState = state;
      if (curState is ExploreInitial) {
        final trending = await _getExploreUseCase.call(
          from: 0,
          size: fetchSize,
        );
        yield ExploreLoaded(trending: trending, hasMore: true);
      } else if (curState is ExploreLoaded) {
        final trending = await _getExploreUseCase.call(
          from: curState.trending.trendingTopics.length,
          size: fetchSize,
        );
        yield trending.trendingTopics.isEmpty
            ? curState.copyWith(hasMore: false)
            : ExploreLoaded(
                trending: Trending(
                  topics: trending.topics,
                  trendingTopics: curState.trending.trendingTopics + trending.trendingTopics,
                ),
                hasMore: true);
      }
    } catch (e) {
      print(e);
      yield ExploreError();
    }
  }

  Stream<ExploreState> _mapRefreshLoadedExploreState(RefreshExploreCallback callback) async* {
    try {
      final curState = state;
      if (curState is ExploreError) {
        yield ExploreLoading();
      }
      final trending = await _getExploreUseCase.call(
        from: 0,
        size: fetchSize,
      );
      yield ExploreLoaded(trending: trending, hasMore: true);
      if (callback != null) callback();
    } catch (_) {
      yield ExploreError();
    }
  }

  @override
  Stream<Transition<ExploreEvent, ExploreState>> transformEvents(Stream<ExploreEvent> events, transitionFn) {
    return super.transformEvents(events.debounceTime(const Duration(milliseconds: 500)), transitionFn);
  }
}
