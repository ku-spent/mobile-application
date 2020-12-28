part of 'history_bloc.dart';

abstract class HistoryEvent extends Equatable {
  const HistoryEvent();

  @override
  List<Object> get props => [];
}

class FetchHistory extends HistoryEvent {}

class RefreshHistory extends HistoryEvent {
  final Function callback;

  const RefreshHistory({this.callback});

  @override
  List<Object> get props => [callback];
}
