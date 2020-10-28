part of 'source_bloc.dart';

abstract class SourceState extends Equatable {
  const SourceState();

  @override
  List<Object> get props => [];
}

class SourceInitial extends SourceState {
  @override
  List<Object> get props => [];
}

class SourceLoaded extends SourceState {
  final List<News> feeds;
  final bool hasMore;

  const SourceLoaded({@required this.feeds, @required this.hasMore});

  @override
  List<Object> get props => [feeds, hasMore];

  SourceLoaded copyWith({List<News> feeds, bool hasMore}) {
    return SourceLoaded(
        feeds: feeds ?? this.feeds, hasMore: hasMore ?? this.hasMore);
  }
}

class SourceError extends SourceState {
  @override
  List<Object> get props => [];
}
