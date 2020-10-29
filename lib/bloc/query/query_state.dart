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

  const QueryFeedLoaded({@required this.feeds, @required this.hasMore});

  @override
  List<Object> get props => [feeds, hasMore];

  QueryFeedLoaded copyWith({List<News> feeds, bool hasMore}) {
    return QueryFeedLoaded(
        feeds: feeds ?? this.feeds, hasMore: hasMore ?? this.hasMore);
  }
}

class QueryFeedError extends QueryFeedState {
  @override
  List<Object> get props => [];
}
