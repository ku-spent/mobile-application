import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:injectable/injectable.dart';
import 'package:spent/domain/use_case/user_signin_with_authcode_use_case.dart';
import 'package:spent/presentation/bloc/authentication/authentication_bloc.dart';

part 'signin_event.dart';
part 'signin_state.dart';

@injectable
class SigninBloc extends Bloc<SigninEvent, SigninState> {
  final UserSignInWithAuthCodeUseCase _userSignInWithAuthCodeUseCase;
  final AuthenticationBloc _authenticationBloc;

  SigninBloc(this._userSignInWithAuthCodeUseCase, this._authenticationBloc) : super(SigninInitial());

  @override
  Stream<SigninState> mapEventToState(
    SigninEvent event,
  ) async* {
    if (event is InitialSignin) {
      yield* _mapInitialSigninToState(event);
    } else if (event is SignInWithFederatedCognitoAuthCode) {
      yield* _mapSignInWithFederatedCognitoAuthCodeToState(event);
    }
  }

  Stream<SigninState> _mapInitialSigninToState(InitialSignin event) async* {
    print('initial');
    yield SigninInitial();
  }

  Stream<SigninState> _mapSignInWithFederatedCognitoAuthCodeToState(SignInWithFederatedCognitoAuthCode event) async* {
    yield SigninLoading();
    try {
      final user = await _userSignInWithAuthCodeUseCase.call(event.authCode);
      if (user != null) {
        _authenticationBloc.add(UserSignedIn(user: user));
        yield SigninSuccess();
      } else {
        yield SigninError(error: 'Something very weird just happened');
      }
    } catch (e) {
      yield SigninError(error: e.message ?? 'An unknown error occured');
    }
  }
}
