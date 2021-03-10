part of 'query_bloc.dart';

abstract class QueryFeedEvent extends Equatable {
  const QueryFeedEvent();

  @override
  List<Object> get props => [];
}

class InitialQueryFeed extends QueryFeedEvent {
  final QueryObject query;

  const InitialQueryFeed({@required this.query});

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

  const RefreshQueryFeed({this.callback});

  @override
  List<Object> get props => [];
}

typedef RefreshFeedCallback = void Function();
