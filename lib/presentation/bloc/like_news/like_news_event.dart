part of 'like_news_bloc.dart';

abstract class LikeNewsEvent extends Equatable {
  const LikeNewsEvent();

  @override
  List<Object> get props => [];
}

class LikeNews extends LikeNewsEvent {
  final News news;

  const LikeNews({@required this.news});

  @override
  List<Object> get props => [news];
}
