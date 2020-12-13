part of 'signin_bloc.dart';

abstract class SigninEvent extends Equatable {
  const SigninEvent();

  @override
  List<Object> get props => [];
}

typedef SignInOnSuccess = void Function();

class InitialSignin extends SigninEvent {}

class SignInWithHostedUi extends SigninEvent {
  const SignInWithHostedUi();
}

class SignInWithFederatedCognitoAuthCode extends SigninEvent {
  final String authCode;

  const SignInWithFederatedCognitoAuthCode({@required this.authCode});

  @override
  List<Object> get props => [authCode];
}
