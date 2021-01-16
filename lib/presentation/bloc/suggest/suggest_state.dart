part of 'suggest_bloc.dart';

abstract class SuggestFeedState extends Equatable {
  const SuggestFeedState();

  @override
  List<Object> get props => [];
}

class SuggestFeedInitial extends SuggestFeedState {
  @override
  List<Object> get props => [];
}

class SuggestFeedLoading extends SuggestFeedState {
  @override
  List<Object> get props => [];
}

class SuggestFeedLoaded extends SuggestFeedState {
  final List<News> feeds;
  final bool hasMore;
  final News curNews;

  const SuggestFeedLoaded({
    @required this.feeds,
    @required this.hasMore,
    @required this.curNews,
  });

  @override
  List<Object> get props => [feeds, hasMore, curNews];

  SuggestFeedLoaded copyWith({List<News> feeds, bool hasMore, String query}) {
    return SuggestFeedLoaded(
      feeds: feeds ?? this.feeds,
      hasMore: hasMore ?? this.hasMore,
      curNews: curNews,
    );
  }
}

class SuggestFeedError extends SuggestFeedState {
  @override
  List<Object> get props => [];
}
