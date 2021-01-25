import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';
import 'package:spent/domain/model/News.dart';
import 'package:spent/domain/use_case/event/send_event_bookmark_news_use_case.dart';
import 'package:spent/domain/use_case/event/send_event_like_news_use_case.dart';
import 'package:spent/domain/use_case/event/send_event_share_news_use_case.dart';
import 'package:spent/domain/use_case/event/send_event_view_news_use_case.dart';

part 'user_event_event.dart';
part 'user_event_state.dart';

@injectable
class UserEventBloc extends Bloc<UserEventEvent, UserEventState> {
  final SendEventViewNewsUseCase _sendEventViewNewsUseCase;
  final SendEventLikeNewsUseCase _sendEventLikeNewsUseCase;
  final SendEventShareNewsUseCase _sendEventShareNewsUseCase;
  final SendEventBookmarkNewsUseCase _sendEventBookmarkNewsUseCase;

  UserEventBloc(
    this._sendEventViewNewsUseCase,
    this._sendEventBookmarkNewsUseCase,
    this._sendEventLikeNewsUseCase,
    this._sendEventShareNewsUseCase,
  ) : super(UserEventInitial());

  @override
  Stream<UserEventState> mapEventToState(
    UserEventEvent event,
  ) async* {
    if (event is SendViewNewsEvent) {
      yield* _mapSendingViewNewsEventState(event);
    } else if (event is SendLikeNewsEvent) {
      yield* _mapSendingLikeNewsEventState(event);
    } else if (event is SendShareNewsEvent) {
      yield* _mapSendingShareNewsEventState(event);
    } else if (event is SendBookmarkNewsEvent) {
      yield* _mapSendingBookmarkNewsEventState(event);
    }
  }

  Stream<UserEventState> _mapSendingViewNewsEventState(SendViewNewsEvent event) async* {
    try {
      yield UserEventSending();
      await _sendEventViewNewsUseCase(event.news);
      yield UserEventSuccess();
    } catch (_) {
      yield UserEventError();
    }
  }

  Stream<UserEventState> _mapSendingLikeNewsEventState(SendLikeNewsEvent event) async* {
    try {
      yield UserEventSending();
      await _sendEventLikeNewsUseCase(event.news);
      yield UserEventSuccess();
    } catch (_) {
      yield UserEventError();
    }
  }

  Stream<UserEventState> _mapSendingShareNewsEventState(SendShareNewsEvent event) async* {
    try {
      yield UserEventSending();
      await _sendEventShareNewsUseCase(event.news);
      yield UserEventSuccess();
    } catch (_) {
      yield UserEventError();
    }
  }

  Stream<UserEventState> _mapSendingBookmarkNewsEventState(SendBookmarkNewsEvent event) async* {
    try {
      yield UserEventSending();
      await _sendEventBookmarkNewsUseCase(event.news);
      yield UserEventSuccess();
    } catch (_) {
      yield UserEventError();
    }
  }
}
