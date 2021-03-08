import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';
import 'package:spent/domain/model/News.dart';
import 'package:spent/domain/use_case/delete_user_view_news_history_use_case.dart';
import 'package:spent/domain/use_case/save_user_view_news_history_use_case.dart';
import 'package:spent/presentation/bloc/user_event/user_event_bloc.dart';

part 'manage_history_event.dart';
part 'manage_history_state.dart';

@singleton
class ManageHistoryBloc extends Bloc<ManageHistoryEvent, ManageHistoryState> {
  final DeleteUserViewNewsHistoryUseCase _deleteUserViewNewsHistoryUseCase;
  final SaveUserViewNewsHistoryUseCase _saveUserViewNewsHistoryUseCase;
  final UserEventBloc _userEventBloc;

  ManageHistoryBloc(this._saveUserViewNewsHistoryUseCase, this._deleteUserViewNewsHistoryUseCase, this._userEventBloc)
      : super(ManageHistoryInitial());

  @override
  Stream<ManageHistoryState> mapEventToState(
    ManageHistoryEvent event,
  ) async* {
    if (event is SaveHistory) {
      yield* _mapSaveHistoryLoadedState(event);
    } else if (event is DeleteHistory) {
      yield* _mapDeleteHistoryState(event);
    }
  }

  Stream<ManageHistoryState> _mapSaveHistoryLoadedState(SaveHistory event) async* {
    yield ManageHistoryLoading();
    try {
      await _saveUserViewNewsHistoryUseCase.call(event.news);
      _userEventBloc.add(SendViewNewsEvent(news: event.news));
      yield SaveHistorySuccess(event.news);
    } catch (e) {
      print(e);
      yield ManageHistoryLoadError();
    }
  }

  Stream<ManageHistoryState> _mapDeleteHistoryState(DeleteHistory event) async* {
    yield ManageHistoryLoading();
    try {
      await _deleteUserViewNewsHistoryUseCase.call(event.news);
      // _userEventBloc.add(SendViewNewsEvent(news: event.news));
      yield DeleteHistorySuccess(event.news);
    } catch (e) {
      print(e);
      yield ManageHistoryLoadError();
    }
  }
}
