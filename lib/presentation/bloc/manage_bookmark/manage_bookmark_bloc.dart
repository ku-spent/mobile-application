import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';
import 'package:spent/domain/model/News.dart';
import 'package:spent/domain/use_case/delete_bookmark_use_case.dart';
import 'package:spent/domain/use_case/save_bookmark_use_case.dart';
import 'package:spent/presentation/bloc/user_event/user_event_bloc.dart';

part 'manage_bookmark_event.dart';
part 'manage_bookmark_state.dart';

@singleton
class ManageBookmarkBloc extends Bloc<ManageBookmarkEvent, ManageBookmarkState> {
  final SaveBookmarkUseCase _saveBookmarkUseCase;
  final DeleteBookmarkUseCase _deleteBookmarkUseCase;
  final UserEventBloc _userEventBloc;

  ManageBookmarkBloc(this._saveBookmarkUseCase, this._userEventBloc, this._deleteBookmarkUseCase)
      : super(ManageBookmarkInitial());

  @override
  Stream<ManageBookmarkState> mapEventToState(
    ManageBookmarkEvent event,
  ) async* {
    if (event is SaveBookmark) {
      yield* _mapSaveBookmarkLoadedState(event);
    } else if (event is DeleteBookmark) {
      yield* _mapDeleteBookmarkLoadedState(event);
    }
  }

  Stream<ManageBookmarkState> _mapSaveBookmarkLoadedState(SaveBookmark event) async* {
    yield ManageBookmarkLoading();
    try {
      final ManageBookmarkResult result = await _saveBookmarkUseCase.call(event.news);
      _userEventBloc.add(SendBookmarkNewsEvent(news: event.news));
      yield SaveBookmarkSuccess(event.news, result);
    } catch (e) {
      print(e);
      yield ManageBookmarkLoadError();
    }
  }

  Stream<ManageBookmarkState> _mapDeleteBookmarkLoadedState(DeleteBookmark event) async* {
    yield ManageBookmarkLoading();
    try {
      final ManageBookmarkResult result = await _deleteBookmarkUseCase.call(event.news);
      // _userEventBloc.add(SendBookmarkNewsEvent(news: event.news));
      yield DeleteBookmarkSuccess(event.news, result);
    } catch (e) {
      print(e);
      yield ManageBookmarkLoadError();
    }
  }
}

class ManageBookmarkResult extends Equatable {
  final bool isBookmarked;

  const ManageBookmarkResult({this.isBookmarked});

  @override
  List<Object> get props => [isBookmarked];
}
