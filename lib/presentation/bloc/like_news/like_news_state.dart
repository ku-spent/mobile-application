part of 'like_news_bloc.dart';

abstract class LikeNewsState extends Equatable {
  const LikeNewsState();

  @override
  List<Object> get props => [];
}

class LikeNewsInitial extends LikeNewsState {}

class LikeNewsLoading extends LikeNewsState {}

class LikeNewsSuccess extends LikeNewsState {}

class LikeNewsLoadError extends LikeNewsState {}
