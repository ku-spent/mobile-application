part of 'save_history_bloc.dart';

abstract class SaveHistoryState extends Equatable {
  const SaveHistoryState();

  @override
  List<Object> get props => [];
}

class SaveHistoryInitial extends SaveHistoryState {}

class SaveHistoryLoading extends SaveHistoryState {}

class SaveHistorySuccess extends SaveHistoryState {}

class SaveHistoryLoadError extends SaveHistoryState {}
