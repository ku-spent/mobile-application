part of 'history_bloc.dart';

abstract class HistoryState extends Equatable {
  const HistoryState();

  @override
  List<Object> get props => [];
}

class HistoryInitial extends HistoryState {}

class HistoryLoading extends HistoryState {}

class HistoryLoaded extends HistoryState {
  final List<History> histories;

  const HistoryLoaded(this.histories);

  @override
  List<Object> get props => [histories];
}

class HistoryLoadError extends HistoryState {}
