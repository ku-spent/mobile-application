import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:spent/model/news.dart';
import 'package:spent/repository/feed_repository.dart';

part 'feed_event.dart';
part 'feed_state.dart';

class FeedBloc extends Bloc<FeedEvent, FeedState> {
  FeedRepository feedRepository = FeedRepository();

  FeedBloc() : super(FeedLoading());

  @override
  Stream<FeedState> mapEventToState(
    FeedEvent event,
  ) async* {
    if (event is FetchFeed) {
      yield* _mapLoadedFeedState();
    }
  }

  Stream<FeedState> _mapLoadingFeedState() async* {
    yield FeedLoading();
  }

  Stream<FeedState> _mapLoadedFeedState() async* {
    try {
      yield FeedLoading();
      List<News> news = await feedRepository.fetchFeeds();
      yield FeedLoaded(news);
    } catch (_) {
      yield FeedNotLoaded();
    }
  }
}
