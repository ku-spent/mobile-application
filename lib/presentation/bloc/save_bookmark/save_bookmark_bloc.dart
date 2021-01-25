import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';
import 'package:spent/domain/model/News.dart';
import 'package:spent/domain/use_case/save_bookmark_use_case.dart';
import 'package:spent/presentation/bloc/user_event/user_event_bloc.dart';

part 'save_bookmark_event.dart';
part 'save_bookmark_state.dart';

@singleton
class SaveBookmarkBloc extends Bloc<SaveBookmarkEvent, SaveBookmarkState> {
  final SaveBookmarkUseCase _saveBookmarkUseCase;
  final UserEventBloc _userEventBloc;

  SaveBookmarkBloc(this._saveBookmarkUseCase, this._userEventBloc) : super(SaveBookmarkInitial());

  @override
  Stream<SaveBookmarkState> mapEventToState(
    SaveBookmarkEvent event,
  ) async* {
    if (event is SaveBookmark) {
      yield* _mapSaveBookmarkLoadedState(event);
    }
  }

  Stream<SaveBookmarkState> _mapSaveBookmarkLoadedState(SaveBookmark event) async* {
    yield SaveBookmarkLoading();
    try {
      SaveBookmarkResult result = await _saveBookmarkUseCase.call(event.news);
      _userEventBloc.add(SendBookmarkNewsEvent(news: event.news));
      yield SaveBookmarkSuccess(event.news, result);
    } catch (e) {
      print(e);
      yield SaveBookmarkLoadError();
    }
  }
}
