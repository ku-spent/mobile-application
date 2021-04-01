part of 'manage_following_bloc.dart';

abstract class ManageFollowingState extends Equatable {
  const ManageFollowingState();

  @override
  List<Object> get props => [];
}

class ManageFollowingInitial extends ManageFollowingState {}

class ManageFollowingLoading extends ManageFollowingState {}

class SaveFollowingSuccess extends ManageFollowingState {
  final Following following;

  const SaveFollowingSuccess(this.following);

  @override
  List<Object> get props => [following];
}

class SaveFollowingListSuccess extends ManageFollowingState {
  final List<Following> followingList;

  const SaveFollowingListSuccess(this.followingList);

  @override
  List<Object> get props => [followingList];
}

class DeleteFollowingSuccess extends ManageFollowingState {
  final Following following;

  const DeleteFollowingSuccess(this.following);

  @override
  List<Object> get props => [following];
}

class ManageFollowingLoadError extends ManageFollowingState {}
