part of 'history_bloc.dart';

abstract class HistoryState extends Equatable {
  const HistoryState();

  @override
  List<Object> get props => [];
}

class HistoryInitial extends HistoryState {}

class HistoryLoading extends HistoryState {}

class HistoryLoaded extends HistoryState {
  final List<News> news;

  const HistoryLoaded(this.news);

  @override
  List<Object> get props => [news];
}

class HistoryLoadError extends HistoryState {}
