part of 'save_bookmark_bloc.dart';

abstract class SaveBookmarkState extends Equatable {
  const SaveBookmarkState();

  @override
  List<Object> get props => [];
}

class SaveBookmarkInitial extends SaveBookmarkState {}

class SaveBookmarkLoading extends SaveBookmarkState {}

class SaveBookmarkSuccess extends SaveBookmarkState {
  final News news;
  final SaveBookmarkResult result;

  const SaveBookmarkSuccess(this.news, this.result);

  @override
  List<Object> get props => [news, result];
}
// class SaveBookmarkSuccess extends SaveBookmarkState {
//   final bool isBookmarked;
//   final News news;

//   const SaveBookmarkSuccess(this.isBookmarked, this.news);

//   @override
//   List<Object> get props => [];
// }

class SaveBookmarkLoadError extends SaveBookmarkState {}
