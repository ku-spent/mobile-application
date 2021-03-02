part of 'manage_block_bloc.dart';

abstract class ManageBlockEvent extends Equatable {
  const ManageBlockEvent();

  @override
  List<Object> get props => [];
}

class SaveBlock extends ManageBlockEvent {
  final List<BlockChoice> blockChoices;

  const SaveBlock({@required this.blockChoices});

  @override
  List<Object> get props => [blockChoices];
}

class DeleteBlock extends ManageBlockEvent {
  final Block block;

  const DeleteBlock({@required this.block});

  @override
  List<Object> get props => [block];
}
