part of 'query_bloc.dart';

abstract class QueryFeedState extends Equatable {
  const QueryFeedState();

  @override
  List<Object> get props => [];
}

class QueryFeedInitial extends QueryFeedState {
  @override
  List<Object> get props => [];
}

class QueryFeedLoaded extends QueryFeedState {
  final List<News> feeds;
  final bool hasMore;
  final String query;

  const QueryFeedLoaded({
    @required this.feeds,
    @required this.hasMore,
    @required this.query,
  });

  @override
  List<Object> get props => [feeds, hasMore, query];

  QueryFeedLoaded copyWith({List<News> feeds, bool hasMore, String query}) {
    return QueryFeedLoaded(
      feeds: feeds ?? this.feeds,
      hasMore: hasMore ?? this.hasMore,
      query: query,
    );
  }
}

class QueryFeedError extends QueryFeedState {
  @override
  List<Object> get props => [];
}
