part of 'history_bloc.dart';

abstract class HistoryEvent extends Equatable {
  const HistoryEvent();

  @override
  List<Object> get props => [];
}

class FetchHistory extends HistoryEvent {
  final String query;

  const FetchHistory({this.query});

  @override
  List<Object> get props => [query];
}

class RefreshHistory extends HistoryEvent {
  final String query;
  final Function callback;

  const RefreshHistory({this.query, this.callback});

  @override
  List<Object> get props => [query, callback];
}

class RemoveHistoryFromList extends HistoryEvent {
  final News news;

  const RemoveHistoryFromList({this.news});

  @override
  List<Object> get props => [news];
}
