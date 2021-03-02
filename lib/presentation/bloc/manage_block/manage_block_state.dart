part of 'manage_block_bloc.dart';

abstract class ManageBlockState extends Equatable {
  const ManageBlockState();

  @override
  List<Object> get props => [];
}

class ManageBlockInitial extends ManageBlockState {}

class ManageBlockLoading extends ManageBlockState {}

class SaveBlockSuccess extends ManageBlockState {
  // final Block block;

  // const SaveBlockSuccess(this.block);

  // @override
  // List<Object> get props => [block];
}

class DeleteBlockSuccess extends ManageBlockState {
  final Block block;

  const DeleteBlockSuccess(this.block);

  @override
  List<Object> get props => [block];
}

class ManageBlockLoadError extends ManageBlockState {}
