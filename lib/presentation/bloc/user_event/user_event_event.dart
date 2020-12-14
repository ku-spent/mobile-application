part of 'user_event_bloc.dart';

abstract class UserEventEvent extends Equatable {
  const UserEventEvent();

  @override
  List<Object> get props => [];
}

class ReadNewsEvent extends UserEventEvent {
  final News news;

  const ReadNewsEvent({@required this.news});

  @override
  List<Object> get props => [news];
}
