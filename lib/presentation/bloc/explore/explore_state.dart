part of 'explore_bloc.dart';

abstract class ExploreState extends Equatable {
  const ExploreState();

  @override
  List<Object> get props => [];
}

class ExploreInitial extends ExploreState {
  @override
  List<Object> get props => [];
}

class ExploreLoading extends ExploreState {
  @override
  List<Object> get props => [];
}

class ExploreLoaded extends ExploreState {
  final Trending trending;
  final bool hasMore;

  const ExploreLoaded({@required this.trending, @required this.hasMore});

  @override
  List<Object> get props => [trending, hasMore];

  ExploreLoaded copyWith({Trending trending, bool hasMore}) {
    return ExploreLoaded(trending: trending ?? this.trending, hasMore: hasMore ?? this.hasMore);
  }
}

class ExploreError extends ExploreState {
  @override
  List<Object> get props => [];
}
