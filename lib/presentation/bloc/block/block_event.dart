part of 'block_bloc.dart';

abstract class BlockEvent extends Equatable {
  const BlockEvent();

  @override
  List<Object> get props => [];
}

class FetchBlock extends BlockEvent {
  final String query;

  const FetchBlock({this.query});

  @override
  List<Object> get props => [query];
}

class RefreshBlock extends BlockEvent {
  final String query;
  final Function callback;

  const RefreshBlock({this.query, this.callback});

  @override
  List<Object> get props => [query, callback];
}

class RemoveBlockFromList extends BlockEvent {
  final Block block;

  const RemoveBlockFromList({this.block});

  @override
  List<Object> get props => [block];
}
