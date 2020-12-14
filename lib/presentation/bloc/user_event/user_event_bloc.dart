import 'dart:async';

import 'package:amplify_analytics_pinpoint/amplify_analytics_pinpoint.dart';
import 'package:amplify_core/amplify_core.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';
import 'package:spent/domain/model/news.dart';

part 'user_event_event.dart';
part 'user_event_state.dart';

@singleton
class UserEventBloc extends Bloc<UserEventEvent, UserEventState> {
  UserEventBloc() : super(UserEventInitial());

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

      AnalyticsEvent analyticsEvent = AnalyticsEvent("ReadNews");
      analyticsEvent.properties.addStringProperty("url", event.news.url);
      Amplify.Analytics.recordEvent(event: analyticsEvent);

      yield UserEventSuccess();
    } catch (_) {
      yield UserEventError();
    }
  }
}
