part of 'save_history_bloc.dart';

abstract class SaveHistoryEvent extends Equatable {
  const SaveHistoryEvent();

  @override
  List<Object> get props => [];
}

class SaveHistory extends SaveHistoryEvent {
  final News news;

  const SaveHistory({@required this.news});

  @override
  List<Object> get props => [news];
}
