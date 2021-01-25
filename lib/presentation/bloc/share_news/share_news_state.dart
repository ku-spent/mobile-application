part of 'share_news_bloc.dart';

abstract class ShareNewsState extends Equatable {
  const ShareNewsState();

  @override
  List<Object> get props => [];
}

class ShareNewsInitial extends ShareNewsState {}

class ShareNewsLoading extends ShareNewsState {}

class ShareNewsSuccess extends ShareNewsState {
  final News news;

  const ShareNewsSuccess(this.news);

  @override
  List<Object> get props => [news];
}

class ShareNewsLoadError extends ShareNewsState {}
