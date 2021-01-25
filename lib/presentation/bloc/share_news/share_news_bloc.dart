import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';
import 'package:spent/domain/model/ModelProvider.dart';
import 'package:spent/domain/use_case/share_news_use_case.dart';
import 'package:spent/presentation/bloc/user_event/user_event_bloc.dart';

part 'share_news_event.dart';
part 'share_news_state.dart';

@singleton
class ShareNewsBloc extends Bloc<ShareNewsEvent, ShareNewsState> {
  final ShareNewsUseCase _shareNewsUseCase;
  final UserEventBloc _userEventBloc;

  ShareNewsBloc(this._shareNewsUseCase, this._userEventBloc) : super(ShareNewsInitial());

  @override
  Stream<ShareNewsState> mapEventToState(
    ShareNewsEvent event,
  ) async* {
    if (event is ShareNews) {
      yield* _mapShareNewsLoadedState(event);
    }
  }

  Stream<ShareNewsState> _mapShareNewsLoadedState(ShareNews event) async* {
    yield ShareNewsLoading();
    try {
      await _shareNewsUseCase.call(event.context, event.news);
      _userEventBloc.add(SendShareNewsEvent(news: event.news));
      yield ShareNewsSuccess(event.news);
    } catch (e) {
      print(e);
      yield ShareNewsLoadError();
    }
  }
}
