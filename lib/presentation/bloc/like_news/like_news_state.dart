part of 'like_news_bloc.dart';

abstract class LikeNewsState extends Equatable {
  const LikeNewsState();

  @override
  List<Object> get props => [];
}

class LikeNewsInitial extends LikeNewsState {}

class LikeNewsLoading extends LikeNewsState {}

class LikeNewsSuccess extends LikeNewsState {
  final News news;
  final LikeNewsResult result;

  const LikeNewsSuccess(this.news, this.result);

  @override
  List<Object> get props => [news, result];
}

class LikeNewsLoadError extends LikeNewsState {}
