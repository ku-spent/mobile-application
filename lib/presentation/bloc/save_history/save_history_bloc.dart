import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';
import 'package:spent/domain/model/News.dart';
import 'package:spent/domain/use_case/save_user_view_news_history_use_case.dart';
import 'package:spent/presentation/bloc/user_event/user_event_bloc.dart';

part 'save_history_event.dart';
part 'save_history_state.dart';

@singleton
class SaveHistoryBloc extends Bloc<SaveHistoryEvent, SaveHistoryState> {
  final SaveUserViewNewsHistoryUseCase _saveUserViewNewsHistoryUseCase;
  final UserEventBloc _userEventBloc;

  SaveHistoryBloc(this._saveUserViewNewsHistoryUseCase, this._userEventBloc) : super(SaveHistoryInitial());

  @override
  Stream<SaveHistoryState> mapEventToState(
    SaveHistoryEvent event,
  ) async* {
    if (event is SaveHistory) {
      yield* _mapSaveHistoryLoadedState(event);
    }
  }

  Stream<SaveHistoryState> _mapSaveHistoryLoadedState(SaveHistory event) async* {
    yield SaveHistoryLoading();
    try {
      await _saveUserViewNewsHistoryUseCase.call(event.news);
      _userEventBloc.add(SendViewNewsEvent(news: event.news));
      yield SaveHistorySuccess();
    } catch (e) {
      print(e);
      yield SaveHistoryLoadError();
    }
  }
}
