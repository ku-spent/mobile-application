part of 'feed_bloc.dart';

abstract class FeedState extends Equatable {
  const FeedState();

  @override
  List<Object> get props => [];
}

class FeedLoading extends FeedState {
  @override
  List<Object> get props => [];
}

class FeedLoaded extends FeedState {
  final List<News> feeds;

  const FeedLoaded(this.feeds);

  @override
  List<Object> get props => [feeds];
}

class FeedNotLoaded extends FeedState {
  @override
  List<Object> get props => [];
}
