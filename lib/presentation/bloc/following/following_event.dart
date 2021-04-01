part of 'following_bloc.dart';

abstract class FollowingEvent extends Equatable {
  const FollowingEvent();

  @override
  List<Object> get props => [];
}

class FetchFollowing extends FollowingEvent {
  final String name;
  final FollowingType type;

  const FetchFollowing(this.name, this.type);

  @override
  List<Object> get props => [name, type];
}

class FetchFollowingList extends FollowingEvent {
  const FetchFollowingList();
}

class RefreshFollowingList extends FollowingEvent {
  final Function callback;

  const RefreshFollowingList({this.callback});

  @override
  List<Object> get props => [callback];
}

class RemoveFollowingFromList extends FollowingEvent {
  final Following following;

  const RemoveFollowingFromList(this.following);

  @override
  List<Object> get props => [following];
}
