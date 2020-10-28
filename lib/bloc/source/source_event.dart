part of 'source_bloc.dart';

abstract class SourceEvent extends Equatable {
  const SourceEvent();

  @override
  List<Object> get props => [];
}

class FetchSource extends SourceEvent {
  @override
  List<Object> get props => [];
}

class RefreshSource extends SourceEvent {
  final RefreshFeedCallback callback;
  final String source;

  const RefreshSource({@required this.source, this.callback});

  @override
  List<Object> get props => [];
}

typedef RefreshFeedCallback = void Function();
