part of 'share_news_bloc.dart';

abstract class ShareNewsEvent extends Equatable {
  const ShareNewsEvent();

  @override
  List<Object> get props => [];
}

class ShareNews extends ShareNewsEvent {
  final BuildContext context;
  final News news;

  const ShareNews({@required this.context, @required this.news});

  @override
  List<Object> get props => [news];
}
