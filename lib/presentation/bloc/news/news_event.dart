part of 'news_bloc.dart';

abstract class NewsEvent extends Equatable {
  const NewsEvent();

  @override
  List<Object> get props => [];
}

class BookmarkNews extends NewsEvent {
  final News news;

  const BookmarkNews({@required this.news});

  @override
  List<Object> get props => [news];
}

class HistoryNews extends NewsEvent {
  final News news;

  const HistoryNews({@required this.news});

  @override
  List<Object> get props => [news];
}

class LikeNews extends NewsEvent {
  final News news;

  const LikeNews({@required this.news});

  @override
  List<Object> get props => [news];
}
