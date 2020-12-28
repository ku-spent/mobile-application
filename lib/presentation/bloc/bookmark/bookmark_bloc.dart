import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';
import 'package:spent/domain/model/ModelProvider.dart';
import 'package:spent/domain/model/News.dart';
import 'package:spent/domain/use_case/get_bookmark_use_case.dart';
import 'package:spent/domain/use_case/save_bookmark_use_case.dart';

part 'bookmark_event.dart';
part 'bookmark_state.dart';

@singleton
class BookmarkBloc extends Bloc<BookmarkEvent, BookmarkState> {
  final GetBookmarkUseCase _bookmarkUseCase;
  final SaveBookmarkUseCase _saveBookmarkUseCase;

  BookmarkBloc(this._bookmarkUseCase, this._saveBookmarkUseCase) : super(BookmarkInitial());

  @override
  Stream<BookmarkState> mapEventToState(
    BookmarkEvent event,
  ) async* {
    if (event is FetchBookmark) {
      yield* _mapBookmarkLoadedState(event);
    } else if (event is SaveBookmark) {
      yield* _mapSaveBookmarkLoadedState(event);
    }
  }

  Stream<BookmarkState> _mapSaveBookmarkLoadedState(SaveBookmark event) async* {
    yield SaveBookmarkLoading();
    try {
      await _saveBookmarkUseCase.call(event.news);
      yield SaveBookmarkSuccess();
    } catch (e) {
      print(e);
      yield SaveBookmarkLoadError();
    }
  }

  Stream<BookmarkState> _mapBookmarkLoadedState(FetchBookmark event) async* {
    yield BookmarkLoading();
    try {
      List<News> bookmarksNews = await _bookmarkUseCase.call();
      yield BookmarkLoaded(bookmarksNews);
    } catch (e) {
      print(e);
      yield BookmarkLoadError();
    }
  }
}
