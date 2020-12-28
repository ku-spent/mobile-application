part of 'bookmark_bloc.dart';

abstract class BookmarkState extends Equatable {
  const BookmarkState();

  @override
  List<Object> get props => [];
}

class BookmarkInitial extends BookmarkState {}

class BookmarkLoading extends BookmarkState {}

class BookmarkLoaded extends BookmarkState {
  final List<News> news;

  const BookmarkLoaded(this.news);

  @override
  List<Object> get props => [news];
}

class BookmarkLoadError extends BookmarkState {}

class SaveBookmarkLoading extends BookmarkState {}

class SaveBookmarkSuccess extends BookmarkState {}

class SaveBookmarkLoadError extends BookmarkState {}
