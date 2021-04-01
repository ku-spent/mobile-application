part of 'like_news_bloc.dart';

abstract class LikeNewsEvent extends Equatable {
  const LikeNewsEvent();

  @override
  List<Object> get props => [];
}

class LikeNews extends LikeNewsEvent {
  final News news;
  final String recommendationId;

  const LikeNews({@required this.news, this.recommendationId});

  @override
  List<Object> get props => [news];
}
