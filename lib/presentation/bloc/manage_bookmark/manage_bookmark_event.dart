part of 'manage_bookmark_bloc.dart';

abstract class ManageBookmarkEvent extends Equatable {
  const ManageBookmarkEvent();

  @override
  List<Object> get props => [];
}

class SaveBookmark extends ManageBookmarkEvent {
  final News news;

  const SaveBookmark({@required this.news});

  @override
  List<Object> get props => [news];
}

class DeleteBookmark extends ManageBookmarkEvent {
  final News news;

  const DeleteBookmark({@required this.news});

  @override
  List<Object> get props => [news];
}
