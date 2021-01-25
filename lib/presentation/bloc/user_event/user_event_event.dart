part of 'user_event_bloc.dart';

abstract class UserEventEvent extends Equatable {
  const UserEventEvent();

  @override
  List<Object> get props => [];
}

class SendViewNewsEvent extends UserEventEvent {
  final News news;

  const SendViewNewsEvent({@required this.news});

  @override
  List<Object> get props => [news];
}

class SendLikeNewsEvent extends UserEventEvent {
  final News news;

  const SendLikeNewsEvent({@required this.news});

  @override
  List<Object> get props => [news];
}

class SendShareNewsEvent extends UserEventEvent {
  final News news;

  const SendShareNewsEvent({@required this.news});

  @override
  List<Object> get props => [news];
}

class SendBookmarkNewsEvent extends UserEventEvent {
  final News news;

  const SendBookmarkNewsEvent({@required this.news});

  @override
  List<Object> get props => [news];
}
