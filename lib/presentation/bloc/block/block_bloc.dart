import 'dart:async';

import 'package:rxdart/rxdart.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import 'package:spent/domain/model/Block.dart';
import 'package:spent/domain/model/ModelProvider.dart';
import 'package:spent/domain/use_case/get_blocks_use_case.dart';

part 'block_event.dart';
part 'block_state.dart';

@singleton
class BlockBloc extends Bloc<BlockEvent, BlockState> {
  final int fetchSize = 100;
  final GetBlocksUseCase _getBlocksUseCase;

  BlockBloc(this._getBlocksUseCase) : super(BlockInitial());

  @override
  Stream<BlockState> mapEventToState(
    BlockEvent event,
  ) async* {
    if (event is FetchBlock) {
      yield* _mapBlockLoadedState(event);
    } else if (event is RefreshBlock) {
      yield* _mapRefreshBlockLoadedState(event);
    } else if (event is RemoveBlockFromList) {
      yield* _mapRemoveBlockFromListState(event);
    }
  }

  Stream<BlockState> _mapBlockLoadedState(FetchBlock event) async* {
    try {
      final curState = state;
      if (curState is BlockInitial) {
        // yield BlockLoading();
        final List<Block> blocks = await _getBlocksUseCase.call(query: '', from: 0, size: fetchSize);
        yield BlockLoaded(blocks: blocks, hasMore: blocks.length == fetchSize);
      } else if (curState is BlockLoaded) {
        final List<Block> blocks =
            await _getBlocksUseCase.call(query: event.query, from: curState.blocks.length, size: fetchSize);
        yield blocks.isEmpty
            ? curState.copyWith(hasMore: false)
            : BlockLoaded(blocks: curState.blocks + blocks, hasMore: true);
      }
    } catch (e) {
      print(e);
      yield BlockLoadError();
    }
  }

  Stream<BlockState> _mapRefreshBlockLoadedState(RefreshBlock event) async* {
    try {
      final List<Block> blocks = await _getBlocksUseCase.call(query: event.query, from: 0, size: fetchSize);
      yield BlockLoaded(blocks: blocks, hasMore: blocks.length == fetchSize);
    } catch (e) {
      print(e);
      yield BlockLoadError();
    } finally {
      if (event.callback != null) {
        event.callback();
      }
    }
  }

  Stream<BlockState> _mapRemoveBlockFromListState(RemoveBlockFromList event) async* {
    try {
      final curState = state;
      if (curState is BlockLoaded) {
        yield curState.copyWith(
          blocks: curState.blocks.where((element) => element.id != event.block.id).toList(),
          hasMore: curState.hasMore,
        );
      }
    } catch (e) {
      print(e);
      yield BlockLoadError();
    }
  }

  @override
  Stream<Transition<BlockEvent, BlockState>> transformEvents(Stream<BlockEvent> events, transitionFn) {
    return super.transformEvents(events.debounceTime(const Duration(milliseconds: 500)), transitionFn);
  }
}
