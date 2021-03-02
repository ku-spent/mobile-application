part of 'block_bloc.dart';

abstract class BlockState extends Equatable {
  const BlockState();

  @override
  List<Object> get props => [];
}

class BlockInitial extends BlockState {}

class BlockLoading extends BlockState {}

class BlockLoaded extends BlockState {
  final bool hasMore;
  final List<Block> blocks;

  const BlockLoaded({this.blocks, this.hasMore});

  BlockLoaded copyWith({List<Block> blocks, bool hasMore}) {
    return BlockLoaded(blocks: blocks ?? this.blocks, hasMore: hasMore ?? this.hasMore);
  }

  @override
  List<Object> get props => [blocks, hasMore];
}

class BlockLoadError extends BlockState {}
