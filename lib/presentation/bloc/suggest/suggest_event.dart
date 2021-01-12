part of 'suggest_bloc.dart';

abstract class SuggestFeedEvent extends Equatable {
  const SuggestFeedEvent();

  @override
  List<Object> get props => [];
}

class InitialSuggestFeed extends SuggestFeedEvent {
  final String query;
  final String queryField;

  const InitialSuggestFeed({@required this.query, @required this.queryField});

  @override
  List<Object> get props => [];
}

class FetchSuggestFeed extends SuggestFeedEvent {
  @override
  List<Object> get props => [];
}

class ClearSuggestFeed extends SuggestFeedEvent {
  @override
  List<Object> get props => [];
}

class RefreshSuggestFeed extends SuggestFeedEvent {
  final RefreshFeedCallback callback;
  final String source;

  const RefreshSuggestFeed({@required this.source, this.callback});

  @override
  List<Object> get props => [];
}

typedef RefreshFeedCallback = void Function();
