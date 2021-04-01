import 'dart:async';

import 'package:rxdart/rxdart.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:spent/domain/model/Following.dart';
import 'package:spent/domain/use_case/get_following_list_use_case.dart';
import 'package:spent/domain/use_case/get_following_name_use_case.dart';

part 'following_event.dart';
part 'following_state.dart';

@injectable
class FollowingBloc extends Bloc<FollowingEvent, FollowingState> {
  final GetFollowingListUseCase _getFollowingListUseCase;
  final GetFollowingByNameUseCase _getFollowingByNameUseCase;

  FollowingBloc(this._getFollowingListUseCase, this._getFollowingByNameUseCase) : super(FollowingInitial());

  @override
  Stream<FollowingState> mapEventToState(
    FollowingEvent event,
  ) async* {
    if (event is FetchFollowingList) {
      yield* _mapFollowingListLoadedState(event);
    } else if (event is FetchFollowing) {
      yield* _mapFollowingLoadedState(event);
    } else if (event is RefreshFollowingList) {
      yield* _mapRefreshFollowingLoadedState(event);
    } else if (event is RemoveFollowingFromList) {
      yield* _mapRemoveFollowingFromListState(event);
    }
  }

  Stream<FollowingState> _mapFollowingListLoadedState(FetchFollowingList event) async* {
    try {
      final List<Following> followingList = await _getFollowingListUseCase();
      yield FollowingListLoaded(followingList);
    } catch (e) {
      print(e);
      yield FollowingLoadError();
    }
  }

  Stream<FollowingState> _mapFollowingLoadedState(FetchFollowing event) async* {
    try {
      final Following following = await _getFollowingByNameUseCase(event.name, event.type);
      yield FollowingLoaded(following);
    } catch (e) {
      print(e);
      yield FollowingLoadError();
    }
  }

  Stream<FollowingState> _mapRefreshFollowingLoadedState(RefreshFollowingList event) async* {
    try {
      final List<Following> followingList = await _getFollowingListUseCase();
      yield FollowingListLoaded(followingList);
    } catch (e) {
      print(e);
      yield FollowingLoadError();
    } finally {
      if (event.callback != null) {
        event.callback();
      }
    }
  }

  Stream<FollowingState> _mapRemoveFollowingFromListState(RemoveFollowingFromList event) async* {
    try {
      final curState = state;
      if (curState is FollowingListLoaded) {
        yield FollowingListLoaded(
          curState.followingList.where((element) => element != event.following).toList(),
        );
      }
    } catch (e) {
      print(e);
      yield FollowingLoadError();
    }
  }

  @override
  Stream<Transition<FollowingEvent, FollowingState>> transformEvents(Stream<FollowingEvent> events, transitionFn) {
    return super.transformEvents(events.debounceTime(const Duration(milliseconds: 500)), transitionFn);
  }
}
