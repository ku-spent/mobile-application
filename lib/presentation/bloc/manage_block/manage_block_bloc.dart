import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';
import 'package:spent/domain/model/Choice.dart';
import 'package:spent/domain/model/ModelProvider.dart';

import 'package:spent/domain/use_case/save_block_use_case.dart';
import 'package:spent/domain/use_case/delete_block_use_case.dart';

part 'manage_block_event.dart';
part 'manage_block_state.dart';

@singleton
class ManageBlockBloc extends Bloc<ManageBlockEvent, ManageBlockState> {
  final SaveBlockUseCase _saveBlockUseCase;
  final DeleteBlockUseCase _deleteBlockUseCase;

  ManageBlockBloc(this._saveBlockUseCase, this._deleteBlockUseCase) : super(ManageBlockInitial());

  @override
  Stream<ManageBlockState> mapEventToState(
    ManageBlockEvent event,
  ) async* {
    if (event is SaveBlock) {
      yield* _mapSaveBlockLoadedState(event);
    } else if (event is DeleteBlock) {
      yield* _mapDeleteBlockLoadedState(event);
    }
  }

  Stream<ManageBlockState> _mapSaveBlockLoadedState(SaveBlock event) async* {
    yield ManageBlockLoading();
    try {
      print(event.blockChoices);
      await Future.wait(event.blockChoices.map((e) => _saveBlockUseCase(e.name, e.type)));
      yield SaveBlockSuccess();
    } catch (e) {
      print(e);
      yield ManageBlockLoadError();
    }
  }

  Stream<ManageBlockState> _mapDeleteBlockLoadedState(DeleteBlock event) async* {
    yield ManageBlockLoading();
    try {
      await _deleteBlockUseCase.call(event.block);
      yield DeleteBlockSuccess(event.block);
    } catch (e) {
      print(e);
      yield ManageBlockLoadError();
    }
  }
}
