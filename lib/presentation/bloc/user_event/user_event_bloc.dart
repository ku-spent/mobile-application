import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';
import 'package:spent/domain/model/News.dart';
import 'package:spent/domain/use_case/save_user_view_news_history_use_case.dart';
import 'package:spent/domain/use_case/send_event_view_news_use_case.dart';

part 'user_event_event.dart';
part 'user_event_state.dart';

@singleton
class UserEventBloc extends Bloc<UserEventEvent, UserEventState> {
  final SendEventViewNewsUseCase _sendEventViewNewsUseCase;
  final SaveUserViewNewsHistoryUseCase _saveUserViewNewsHistoryUseCase;

  UserEventBloc(this._sendEventViewNewsUseCase, this._saveUserViewNewsHistoryUseCase) : super(UserEventInitial());

  @override
  Stream<UserEventState> mapEventToState(
    UserEventEvent event,
  ) async* {
    if (event is ReadNewsEvent) {
      yield* _mapUserEventSendingState(event);
    }
  }

  Stream<UserEventState> _mapUserEventSendingState(ReadNewsEvent event) async* {
    try {
      yield UserEventSending();
      await _saveUserViewNewsHistoryUseCase(event.news);
      await _sendEventViewNewsUseCase(event.news);
      yield UserEventSuccess();
    } catch (_) {
      yield UserEventError();
    }
  }
}
