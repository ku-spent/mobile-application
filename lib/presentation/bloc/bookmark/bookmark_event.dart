part of 'bookmark_bloc.dart';

abstract class BookmarkEvent extends Equatable {
  const BookmarkEvent();

  @override
  List<Object> get props => [];
}

class FetchBookmark extends BookmarkEvent {
  final String query;

  const FetchBookmark({this.query});

  @override
  List<Object> get props => [query];
}

class RefreshBookmark extends BookmarkEvent {
  final String query;
  final Function callback;

  const RefreshBookmark({this.query, this.callback});

  @override
  List<Object> get props => [query, callback];
}

class RemoveNewsFromList extends BookmarkEvent {
  final News news;

  const RemoveNewsFromList({this.news});

  @override
  List<Object> get props => [news];
}
