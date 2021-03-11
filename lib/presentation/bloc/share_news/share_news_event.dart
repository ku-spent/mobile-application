part of 'share_news_bloc.dart';

abstract class ShareNewsEvent extends Equatable {
  const ShareNewsEvent();

  @override
  List<Object> get props => [];
}

class ShareNews extends ShareNewsEvent {
  final News news;
  final String recommendationId;
  final BuildContext context;

  const ShareNews({@required this.context, @required this.news, this.recommendationId});

  @override
  List<Object> get props => [news];
}
