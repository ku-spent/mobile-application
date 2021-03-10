part of 'user_event_bloc.dart';

abstract class UserEventEvent extends Equatable {
  const UserEventEvent();

  @override
  List<Object> get props => [];
}

class SendViewNewsEvent extends UserEventEvent {
  final News news;
  final String recommendationId;

  const SendViewNewsEvent({@required this.news, this.recommendationId});

  @override
  List<Object> get props => [news];
}

class SendLikeNewsEvent extends UserEventEvent {
  final News news;
  final String recommendationId;

  const SendLikeNewsEvent({@required this.news, this.recommendationId});

  @override
  List<Object> get props => [news];
}

class SendShareNewsEvent extends UserEventEvent {
  final News news;
  final String recommendationId;

  const SendShareNewsEvent({@required this.news, this.recommendationId});

  @override
  List<Object> get props => [news];
}

class SendBookmarkNewsEvent extends UserEventEvent {
  final News news;
  final String recommendationId;

  const SendBookmarkNewsEvent({@required this.news, this.recommendationId});

  @override
  List<Object> get props => [news];
}
