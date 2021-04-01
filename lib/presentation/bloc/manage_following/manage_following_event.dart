part of 'manage_following_bloc.dart';

abstract class ManageFollowingEvent extends Equatable {
  const ManageFollowingEvent();

  @override
  List<Object> get props => [];
}

class AddFollowing extends ManageFollowingEvent {
  final String name;
  final FollowingType type;

  const AddFollowing(this.name, this.type);

  @override
  List<Object> get props => [name];
}

class SaveFollowingList extends ManageFollowingEvent {
  final List<Following> followingList;

  const SaveFollowingList(this.followingList);

  @override
  List<Object> get props => [followingList];
}

class DeleteFollowing extends ManageFollowingEvent {
  final Following following;

  const DeleteFollowing(this.following);

  @override
  List<Object> get props => [following];
}
