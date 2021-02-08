part of 'explore_bloc.dart';

abstract class ExploreEvent extends Equatable {
  const ExploreEvent();

  @override
  List<Object> get props => [];
}

class FetchExplore extends ExploreEvent {}

class RefreshExplore extends ExploreEvent {
  final RefreshExploreCallback callback;

  const RefreshExplore({this.callback});

  @override
  List<Object> get props => [callback];
}

typedef RefreshExploreCallback = void Function();
