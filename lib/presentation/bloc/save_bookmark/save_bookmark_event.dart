part of 'save_bookmark_bloc.dart';

abstract class SaveBookmarkEvent extends Equatable {
  const SaveBookmarkEvent();

  @override
  List<Object> get props => [];
}

class SaveBookmark extends SaveBookmarkEvent {
  final News news;

  const SaveBookmark({@required this.news});

  @override
  List<Object> get props => [news];
}
