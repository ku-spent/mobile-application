part of 'feed_bloc.dart';

abstract class FeedState extends Equatable {
  const FeedState();

  @override
  List<Object> get props => [];
}

class FeedInitial extends FeedState {
  @override
  List<Object> get props => [];
}

class FeedLoading extends FeedState {
  @override
  List<Object> get props => [];
}

class FeedLoaded extends FeedState {
  final List<News> feeds;
  final bool hasMore;

  const FeedLoaded({@required this.feeds, @required this.hasMore});

  @override
  List<Object> get props => [feeds, hasMore];

  FeedLoaded copyWith({List<News> feeds, bool hasMore}) {
    return FeedLoaded(
        feeds: feeds ?? this.feeds, hasMore: hasMore ?? this.hasMore);
  }
}

class FeedError extends FeedState {
  @override
  List<Object> get props => [];
}
