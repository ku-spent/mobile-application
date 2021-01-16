part of 'suggest_bloc.dart';

abstract class SuggestFeedEvent extends Equatable {
  const SuggestFeedEvent();

  @override
  List<Object> get props => [];
}

class InitialSuggestFeed extends SuggestFeedEvent {
  final News curNews;

  const InitialSuggestFeed({@required this.curNews});

  @override
  List<Object> get props => [curNews];
}

class FetchSuggestFeed extends SuggestFeedEvent {
  final News curNews;

  const FetchSuggestFeed({@required this.curNews});

  @override
  List<Object> get props => [curNews];
}
