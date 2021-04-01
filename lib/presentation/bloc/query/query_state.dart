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

class QueryFeedLoading extends QueryFeedState {
  @override
  List<Object> get props => [];
}

class QueryFeedLoaded extends QueryFeedState {
  final List<News> feeds;
  final bool hasMore;
  final QueryObject query;

  const QueryFeedLoaded({
    @required this.feeds,
    @required this.hasMore,
    @required this.query,
  });

  @override
  List<Object> get props => [feeds, hasMore, query];

  QueryFeedLoaded copyWith({List<News> feeds, bool hasMore, QueryObject query}) {
    return QueryFeedLoaded(
      feeds: feeds ?? this.feeds,
      hasMore: hasMore ?? this.hasMore,
      query: query,
    );
  }
}

class QueryFeedError extends QueryFeedState {
  final QueryObject query;

  QueryFeedError(this.query);

  @override
  List<Object> get props => [query];
}
