import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:injectable/injectable.dart';
import 'package:spent/domain/use_case/identify_user_use_case.dart';
import 'package:spent/domain/use_case/user_signin_with_amplify_use_case.dart';
import 'package:spent/presentation/bloc/authentication/authentication_bloc.dart';

part 'signin_event.dart';
part 'signin_state.dart';

@injectable
class SigninBloc extends Bloc<SigninEvent, SigninState> {
  final UserSignInWithAmplifyUseCase _userSignInWithAmplifyUseCase;
  final IdentifyUserUseCase _identifyUserUseCase;
  final AuthenticationBloc _authenticationBloc;

  SigninBloc(this._authenticationBloc, this._userSignInWithAmplifyUseCase, this._identifyUserUseCase)
      : super(SigninInitial());

  @override
  Stream<SigninState> mapEventToState(
    SigninEvent event,
  ) async* {
    if (event is InitialSignin) {
      yield* _mapInitialSigninToState(event);
    } else if (event is SignInWithHostedUi) {
      yield* _mapSignInWithHostedUiToState(event);
    }
  }

  Stream<SigninState> _mapInitialSigninToState(InitialSignin event) async* {
    yield SigninInitial();
  }

  Stream<SigninState> _mapSignInWithHostedUiToState(SignInWithHostedUi event) async* {
    yield SigninLoading();
    try {
      final user = await _userSignInWithAmplifyUseCase();
      if (user != null) {
        final isValid = await _identifyUserUseCase();
        print('signin: identifyUserUsecase, $isValid');
        if (isValid) {
          _authenticationBloc.add(UserSignedIn(user: user));
          yield SigninSuccess();
          return;
        }
      }
      yield SigninError(error: 'Something very weird just happened');
    } catch (e) {
      yield SigninError(error: e.message ?? 'An unknown error occured');
    }
  }
}
