import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';
import 'package:spent/domain/model/Recommendation.dart';
import 'package:spent/domain/use_case/get_recommendation_use_case.dart';
import 'package:spent/presentation/bloc/network/network_bloc.dart';

part 'recommendation_event.dart';
part 'recommendation_state.dart';

@injectable
class RecommendationBloc extends Bloc<RecommendationEvent, RecommendationState> {
  final int fetchSize = 10;
  final GetRecommendationsUseCase _getNewsRecommendationsUseCase;
  final NetworkBloc _networkBloc;

  RecommendationBloc(this._getNewsRecommendationsUseCase, this._networkBloc) : super(RecommendationInitial());

  @override
  Stream<RecommendationState> mapEventToState(
    RecommendationEvent event,
  ) async* {
    if (event is FetchRecommendation && (__hasMore(state) || state is RecommendationInitial)) {
      yield* _mapLoadedRecommendationState(event);
    } else if (event is RefreshRecommendation) {
      yield* _mapRefreshLoadedRecommendationState(event.callback);
    }
  }

  bool __hasMore(RecommendationState state) => state is RecommendationLoaded && state.hasMore;

  Stream<RecommendationState> _mapLoadedRecommendationState(RecommendationEvent event) async* {
    try {
      final curState = state;
      if (curState is RecommendationInitial) {
        final recommendations = await _getNewsRecommendationsUseCase.call(
          from: 0,
          size: fetchSize,
        );
        yield RecommendationLoaded(recommendations: recommendations, hasMore: false);
      }
      // else if (curState is RecommendationLoaded) {
      //   final recommendations = await _getNewsRecommendationsUseCase.call(
      //     from: curState.recommendations.newsList.length,
      //     size: fetchSize,
      //   );
      //   yield recommendations.isEmpty
      //       ? curState.copyWith(hasMore: false)
      //       : RecommendationLoaded(recommendations: curState.recommendations + recommendations, hasMore: true);
      // }
    } catch (e) {
      print(e);
      yield RecommendationError();
    }
  }

  Stream<RecommendationState> _mapRefreshLoadedRecommendationState(RefreshRecommendationCallback callback) async* {
    try {
      final curState = state;
      if (curState is RecommendationError) {
        yield RecommendationLoading();
      }
      final recommendations = await _getNewsRecommendationsUseCase.call(
        from: 0,
        size: fetchSize,
      );
      yield RecommendationLoaded(recommendations: recommendations, hasMore: false);
      if (callback != null) callback();
    } catch (_) {
      yield RecommendationError();
    }
  }

  @override
  Stream<Transition<RecommendationEvent, RecommendationState>> transformEvents(
      Stream<RecommendationEvent> events, transitionFn) {
    return super.transformEvents(events.debounceTime(const Duration(milliseconds: 500)), transitionFn);
  }
}
