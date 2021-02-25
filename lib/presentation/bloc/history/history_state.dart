part of 'history_bloc.dart';

abstract class HistoryState extends Equatable {
  const HistoryState();

  @override
  List<Object> get props => [];
}

class HistoryInitial extends HistoryState {}

class HistoryLoading extends HistoryState {}

class HistoryLoaded extends HistoryState {
  final bool hasMore;
  final List<News> news;

  const HistoryLoaded({this.news, this.hasMore});

  HistoryLoaded copyWith({List<News> news, bool hasMore}) {
    return HistoryLoaded(news: news ?? this.news, hasMore: hasMore ?? this.hasMore);
  }

  @override
  List<Object> get props => [news, hasMore];
}

class HistoryLoadError extends HistoryState {}
