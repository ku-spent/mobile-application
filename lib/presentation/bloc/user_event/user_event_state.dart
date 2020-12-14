part of 'user_event_bloc.dart';

abstract class UserEventState extends Equatable {
  const UserEventState();

  @override
  List<Object> get props => [];
}

class UserEventInitial extends UserEventState {}

class UserEventSending extends UserEventState {}

class UserEventSuccess extends UserEventState {}

class UserEventError extends UserEventState {}
