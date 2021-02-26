part of 'manage_bookmark_bloc.dart';

abstract class ManageBookmarkState extends Equatable {
  const ManageBookmarkState();

  @override
  List<Object> get props => [];
}

class ManageBookmarkInitial extends ManageBookmarkState {}

class ManageBookmarkLoading extends ManageBookmarkState {}

class SaveBookmarkSuccess extends ManageBookmarkState {
  final News news;
  final ManageBookmarkResult result;

  const SaveBookmarkSuccess(this.news, this.result);

  @override
  List<Object> get props => [news, result];
}

class DeleteBookmarkSuccess extends ManageBookmarkState {
  final News news;
  final ManageBookmarkResult result;

  const DeleteBookmarkSuccess(this.news, this.result);

  @override
  List<Object> get props => [news, result];
}

class ManageBookmarkLoadError extends ManageBookmarkState {}
