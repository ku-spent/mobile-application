import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:spent/domain/model/Following.dart';
import 'package:spent/domain/use_case/delete_following_use_case.dart';
import 'package:spent/domain/use_case/add_following_use_case.dart';
import 'package:spent/domain/use_case/save_following_list_use_case.dart';

part 'manage_following_event.dart';
part 'manage_following_state.dart';

@injectable
class ManageFollowingBloc extends Bloc<ManageFollowingEvent, ManageFollowingState> {
  final AddFollowingUseCase _addFollowingUseCase;
  final SaveFollowingListUseCase _saveFollowingListUseCase;
  final DeleteFollowingUseCase _deleteFollowingUseCase;

  ManageFollowingBloc(this._deleteFollowingUseCase, this._addFollowingUseCase, this._saveFollowingListUseCase)
      : super(ManageFollowingInitial());

  @override
  Stream<ManageFollowingState> mapEventToState(
    ManageFollowingEvent event,
  ) async* {
    if (event is AddFollowing) {
      yield* _mapAddFollowingLoadedState(event);
    } else if (event is SaveFollowingList) {
      yield* _mapSaveFollowingListLoadedState(event);
    } else if (event is DeleteFollowing) {
      yield* _mapDeleteFollowingState(event);
    }
  }

  Stream<ManageFollowingState> _mapAddFollowingLoadedState(AddFollowing event) async* {
    yield ManageFollowingLoading();
    try {
      final Following following = await _addFollowingUseCase.call(event.name, event.type);
      yield SaveFollowingSuccess(following);
    } catch (e) {
      print(e);
      yield ManageFollowingLoadError();
    }
  }

  Stream<ManageFollowingState> _mapSaveFollowingListLoadedState(SaveFollowingList event) async* {
    yield ManageFollowingLoading();
    try {
      await _saveFollowingListUseCase.call(event.followingList);
      yield SaveFollowingListSuccess(event.followingList);
    } catch (e) {
      print(e);
      yield ManageFollowingLoadError();
    }
  }

  Stream<ManageFollowingState> _mapDeleteFollowingState(DeleteFollowing event) async* {
    yield ManageFollowingLoading();
    try {
      await _deleteFollowingUseCase.call(event.following);
      yield DeleteFollowingSuccess(event.following);
    } catch (e) {
      print(e);
      yield ManageFollowingLoadError();
    }
  }
}
