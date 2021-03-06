import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';
import 'package:spent/domain/model/ModelProvider.dart';
import 'package:spent/domain/use_case/like_news_use_case.dart';
import 'package:spent/presentation/bloc/user_event/user_event_bloc.dart';

part 'like_news_event.dart';
part 'like_news_state.dart';

@singleton
class LikeNewsBloc extends Bloc<LikeNewsEvent, LikeNewsState> {
  final LikeNewsUseCase _likeNewsUseCase;
  final UserEventBloc _userEventBloc;

  LikeNewsBloc(this._likeNewsUseCase, this._userEventBloc) : super(LikeNewsInitial());

  @override
  Stream<LikeNewsState> mapEventToState(
    LikeNewsEvent event,
  ) async* {
    if (event is LikeNews) {
      yield* _mapLikeNewsLoadedState(event);
    }
  }

  Stream<LikeNewsState> _mapLikeNewsLoadedState(LikeNews event) async* {
    yield LikeNewsLoading();
    try {
      LikeNewsResult result = await _likeNewsUseCase.call(event.news);
      _userEventBloc.add(SendLikeNewsEvent(news: event.news, recommendationId: event.recommendationId));
      yield LikeNewsSuccess(event.news, result);
    } catch (e) {
      print(e);
      yield LikeNewsLoadError();
    }
  }
}
