part of 'bookmark_bloc.dart';

abstract class BookmarkState extends Equatable {
  const BookmarkState();

  @override
  List<Object> get props => [];
}

class BookmarkInitial extends BookmarkState {}

class BookmarkLoading extends BookmarkState {}

class BookmarkLoaded extends BookmarkState {
  final bool hasMore;
  final List<News> news;

  const BookmarkLoaded({this.news, this.hasMore});

  BookmarkLoaded copyWith({List<News> news, bool hasMore}) {
    return BookmarkLoaded(news: news ?? this.news, hasMore: hasMore ?? this.hasMore);
  }

  @override
  List<Object> get props => [news, hasMore];
}

class BookmarkLoadError extends BookmarkState {}
