import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:injectable/injectable.dart';
import 'package:spent/domain/model/user.dart';
import 'package:spent/domain/use_case/get_current_user_use_case.dart';
import 'package:spent/domain/use_case/user_signout_use_case.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

// @injectable
@singleton
class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {
  final GetCurrentUserUseCase _getCurrentUserUseCase;
  final UserSignOutUseCase _userSignoutUseCase;

  AuthenticationBloc(this._getCurrentUserUseCase, this._userSignoutUseCase) : super(AuthenticationInitial());

  @override
  Stream<AuthenticationState> mapEventToState(
    AuthenticationEvent event,
  ) async* {
    if (event is InitialUser) {
      yield* _mapInitialUserToState(event);
    } else if (event is UserSignedIn) {
      yield* _mapUserSignInToState(event);
    } else if (event is UserSignedOut) {
      yield* _mapUserSignedOutToState(event);
    }
  }

  Stream<AuthenticationState> _mapInitialUserToState(InitialUser event) async* {
    yield AuthenticationLoading();
    try {
      final currentUser = await _getCurrentUserUseCase.call();
      if (currentUser != null) {
        yield AuthenticationAuthenticated(user: currentUser);
      } else {
        yield AuthenticationUnAuthenticated();
      }
    } catch (e) {
      yield AuthenticationError(message: e.message ?? 'An unknown error occurred');
    }
  }

  Stream<AuthenticationState> _mapUserSignInToState(UserSignedIn event) async* {
    yield AuthenticationAuthenticated(user: event.user);
  }

  Stream<AuthenticationState> _mapUserSignedOutToState(UserSignedOut event) async* {
    await _userSignoutUseCase.call();
    print('signout');
    yield AuthenticationUnAuthenticated();
  }
}
