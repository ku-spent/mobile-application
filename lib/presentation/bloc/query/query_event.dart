part of 'query_bloc.dart';

abstract class QueryFeedEvent extends Equatable {
  const QueryFeedEvent();

  @override
  List<Object> get props => [];
}

class InitialQueryFeed extends QueryFeedEvent {
  final String query;
  final String queryField;

  const InitialQueryFeed({@required this.query, @required this.queryField});

  @override
  List<Object> get props => [];
}

class FetchQueryFeed extends QueryFeedEvent {
  @override
  List<Object> get props => [];
}

class ClearQueryFeed extends QueryFeedEvent {
  @override
  List<Object> get props => [];
}

class RefreshQueryFeed extends QueryFeedEvent {
  final RefreshFeedCallback callback;
  final String source;

  const RefreshQueryFeed({@required this.source, this.callback});

  @override
  List<Object> get props => [];
}

typedef RefreshFeedCallback = void Function();
