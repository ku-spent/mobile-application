import 'dart:async';

import 'package:rxdart/rxdart.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:spent/domain/model/ModelProvider.dart';
import 'package:spent/domain/model/News.dart';
import 'package:spent/domain/use_case/get_bookmark_use_case.dart';

part 'bookmark_event.dart';
part 'bookmark_state.dart';

@singleton
class BookmarkBloc extends Bloc<BookmarkEvent, BookmarkState> {
  final int fetchSize = 10;
  final GetBookmarkUseCase _bookmarkUseCase;

  BookmarkBloc(this._bookmarkUseCase) : super(BookmarkInitial());

  @override
  Stream<BookmarkState> mapEventToState(
    BookmarkEvent event,
  ) async* {
    if (event is FetchBookmark) {
      yield* _mapBookmarkLoadedState(event);
    } else if (event is RefreshBookmark) {
      yield* _mapRefreshBookmarkLoadedState(event);
    } else if (event is RemoveNewsFromList) {
      yield* _mapRemoveNewsFromListState(event);
    }
  }

  Stream<BookmarkState> _mapBookmarkLoadedState(FetchBookmark event) async* {
    try {
      final curState = state;
      if (curState is BookmarkInitial) {
        // yield BookmarkLoading();
        final List<News> bookmarksNews = await _bookmarkUseCase.call(query: '', from: 0, size: fetchSize);
        yield BookmarkLoaded(news: bookmarksNews, hasMore: bookmarksNews.length == fetchSize);
      } else if (curState is BookmarkLoaded) {
        final List<News> bookmarksNews =
            await _bookmarkUseCase.call(query: event.query, from: curState.news.length, size: fetchSize);
        yield bookmarksNews.isEmpty
            ? curState.copyWith(hasMore: false)
            : BookmarkLoaded(news: curState.news + bookmarksNews, hasMore: true);
      }
    } catch (e) {
      print(e);
      yield BookmarkLoadError();
    }
  }

  Stream<BookmarkState> _mapRefreshBookmarkLoadedState(RefreshBookmark event) async* {
    try {
      final List<News> bookmarksNews = await _bookmarkUseCase.call(query: event.query, from: 0, size: fetchSize);
      yield BookmarkLoaded(news: bookmarksNews, hasMore: bookmarksNews.length == fetchSize);
    } catch (e) {
      print(e);
      yield BookmarkLoadError();
    } finally {
      if (event.callback != null) {
        event.callback();
      }
    }
  }

  Stream<BookmarkState> _mapRemoveNewsFromListState(RemoveNewsFromList event) async* {
    try {
      final curState = state;
      if (curState is BookmarkLoaded) {
        yield curState.copyWith(
          news: curState.news.where((element) => element.id != event.news.id).toList(),
          hasMore: curState.hasMore,
        );
      }
    } catch (e) {
      print(e);
      yield BookmarkLoadError();
    }
  }

  @override
  Stream<Transition<BookmarkEvent, BookmarkState>> transformEvents(Stream<BookmarkEvent> events, transitionFn) {
    return super.transformEvents(events.debounceTime(const Duration(milliseconds: 500)), transitionFn);
  }
}
