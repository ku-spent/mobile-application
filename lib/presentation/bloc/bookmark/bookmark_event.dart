part of 'bookmark_bloc.dart';

abstract class BookmarkEvent extends Equatable {
  const BookmarkEvent();

  @override
  List<Object> get props => [];
}

class FetchBookmark extends BookmarkEvent {}

class RefreshBookmark extends BookmarkEvent {
  final Function callback;

  const RefreshBookmark({this.callback});

  @override
  List<Object> get props => [callback];
}
