import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';
import 'package:spent/domain/model/ModelProvider.dart';
import 'package:spent/presentation/bloc/like_news/like_news_bloc.dart';
import 'package:spent/presentation/bloc/manage_bookmark/manage_bookmark_bloc.dart';
import 'package:spent/presentation/bloc/manage_history/manage_history_bloc.dart';

part 'news_event.dart';
part 'news_state.dart';

@singleton
class NewsBloc extends Bloc<NewsEvent, NewsState> {
  ManageHistoryBloc _manageHistoryBloc;
  ManageBookmarkBloc _manageBookmarkBloc;
  LikeNewsBloc _likeNewsBloc;

  NewsBloc(this._manageBookmarkBloc, this._manageHistoryBloc, this._likeNewsBloc) : super(NewsInitial());

  @override
  Stream<NewsState> mapEventToState(
    NewsEvent event,
  ) async* {
    if (event is BookmarkNews) {
    } else if (event is HistoryNews) {
    } else if (event is LikeNews) {}
  }

  Stream<NewsState> _mapSaveLikeNewsLoadedState(BookmarkNews event) async* {}
}
