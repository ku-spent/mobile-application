part of 'manage_history_bloc.dart';

abstract class ManageHistoryState extends Equatable {
  const ManageHistoryState();

  @override
  List<Object> get props => [];
}

class ManageHistoryInitial extends ManageHistoryState {}

class ManageHistoryLoading extends ManageHistoryState {}

class SaveHistorySuccess extends ManageHistoryState {
  final News news;

  const SaveHistorySuccess(this.news);

  @override
  List<Object> get props => [news];
}

class DeleteHistorySuccess extends ManageHistoryState {
  final News news;

  const DeleteHistorySuccess(this.news);

  @override
  List<Object> get props => [news];
}

class ManageHistoryLoadError extends ManageHistoryState {}
