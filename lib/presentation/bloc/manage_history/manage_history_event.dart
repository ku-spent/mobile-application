part of 'manage_history_bloc.dart';

abstract class ManageHistoryEvent extends Equatable {
  const ManageHistoryEvent();

  @override
  List<Object> get props => [];
}

class SaveHistory extends ManageHistoryEvent {
  final News news;
  final String recommendationId;

  const SaveHistory({@required this.news, this.recommendationId});

  @override
  List<Object> get props => [news];
}

class DeleteHistory extends ManageHistoryEvent {
  final News news;

  const DeleteHistory({@required this.news});

  @override
  List<Object> get props => [news];
}
