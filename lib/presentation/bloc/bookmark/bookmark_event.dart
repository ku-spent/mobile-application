part of 'bookmark_bloc.dart';

abstract class BookmarkEvent extends Equatable {
  const BookmarkEvent();

  @override
  List<Object> get props => [];
}

class FetchBookmark extends BookmarkEvent {}

class SaveBookmark extends BookmarkEvent {
  final News news;

  const SaveBookmark({@required this.news});

  @override
  List<Object> get props => [news];
}
