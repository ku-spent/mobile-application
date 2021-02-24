part of 'recommendation_bloc.dart';

abstract class RecommendationState extends Equatable {
  const RecommendationState();

  @override
  List<Object> get props => [];
}

class RecommendationInitial extends RecommendationState {
  @override
  List<Object> get props => [];
}

class RecommendationLoading extends RecommendationState {
  @override
  List<Object> get props => [];
}

class RecommendationLoaded extends RecommendationState {
  final Recommendation recommendations;
  final bool hasMore;

  const RecommendationLoaded({@required this.recommendations, @required this.hasMore});

  @override
  List<Object> get props => [recommendations, hasMore];

  RecommendationLoaded copyWith({Recommendation recommendations, bool hasMore}) {
    return RecommendationLoaded(
        recommendations: recommendations ?? this.recommendations, hasMore: hasMore ?? this.hasMore);
  }
}

class RecommendationError extends RecommendationState {
  @override
  List<Object> get props => [];
}
