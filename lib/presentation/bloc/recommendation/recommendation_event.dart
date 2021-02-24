part of 'recommendation_bloc.dart';

abstract class RecommendationEvent extends Equatable {
  const RecommendationEvent();

  @override
  List<Object> get props => [];
}

class FetchRecommendation extends RecommendationEvent {}

class RefreshRecommendation extends RecommendationEvent {
  final RefreshRecommendationCallback callback;

  const RefreshRecommendation({this.callback});

  @override
  List<Object> get props => [callback];
}

typedef RefreshRecommendationCallback = void Function();
