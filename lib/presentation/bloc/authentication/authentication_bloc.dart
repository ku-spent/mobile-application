import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:injectable/injectable.dart';
import 'package:spent/domain/model/User.dart';
import 'package:spent/domain/use_case/get_current_user_use_case.dart';
import 'package:spent/domain/use_case/identify_user_use_case.dart';
import 'package:spent/domain/use_case/initial_authentication_use_case.dart';
import 'package:spent/domain/use_case/user_signout_use_case.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

@singleton
class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {
  final GetCurrentUserUseCase _getCurrentUserUseCase;
  final UserSignOutUseCase _userSignoutUseCase;
  final IdentifyUserUseCase _identifyUserUseCase;
  final InitialAuthenticationUseCase _initialAuthenticationUseCase;

  AuthenticationBloc(this._getCurrentUserUseCase, this._userSignoutUseCase, this._initialAuthenticationUseCase,
      this._identifyUserUseCase)
      : super(AuthenticationInitial());

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
    print('InitialUser');
    yield AuthenticationLoading();
    try {
      final isValid = await _initialAuthenticationUseCase.call();
      print('isValid:: $isValid');
      if (!isValid) {
        yield AuthenticationUnAuthenticated();
        return;
      }

      final currentUser = await _getCurrentUserUseCase.call();
      if (currentUser != null) {
        final isValid = await _identifyUserUseCase();
        print('identifyUsecases $isValid');
        if (isValid) yield AuthenticationAuthenticated(user: currentUser);
        return;
      }
      yield AuthenticationUnAuthenticated();
    } catch (e) {
      yield AuthenticationError(message: e.message ?? 'An unknown error occurred');
    }
  }

  Stream<AuthenticationState> _mapUserSignInToState(UserSignedIn event) async* {
    print('AuthenticationBloc: user signin success');
    yield AuthenticationAuthenticated(user: event.user);
  }

  Stream<AuthenticationState> _mapUserSignedOutToState(UserSignedOut event) async* {
    await _userSignoutUseCase.call();
    print('signout');
    yield AuthenticationUnAuthenticated();
  }
}
