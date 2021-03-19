part of 'following_bloc.dart';

abstract class FollowingState extends Equatable {
  const FollowingState();

  @override
  List<Object> get props => [];
}

class FollowingInitial extends FollowingState {}

class FollowingLoading extends FollowingState {}

class FollowingLoaded extends FollowingState {
  final Following following;

  const FollowingLoaded(this.following);

  @override
  List<Object> get props => [following];
}

class FollowingListLoaded extends FollowingState {
  final List<Following> followingList;

  const FollowingListLoaded(this.followingList);

  @override
  List<Object> get props => [followingList];
}

class FollowingLoadError extends FollowingState {}
