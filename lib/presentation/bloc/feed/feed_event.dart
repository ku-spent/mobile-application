part of 'feed_bloc.dart';

abstract class FeedEvent extends Equatable {
  const FeedEvent();

  @override
  List<Object> get props => [];
}

class FetchFeed extends FeedEvent {}

class RefreshFeed extends FeedEvent {
  final RefreshFeedCallback callback;

  const RefreshFeed({this.callback});

  @override
  List<Object> get props => [callback];
}

typedef RefreshFeedCallback = void Function();
