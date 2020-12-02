import 'package:amazon_cognito_identity_dart_2/cognito.dart';
import 'package:injectable/injectable.dart';
import 'package:spent/data/data_source/authentication/authentication_local_data_souce.dart';
import 'package:spent/data/data_source/authentication/authentication_remote_data_source.dart';
import 'package:spent/domain/model/token.dart';
import 'package:spent/domain/model/user.dart';
import 'package:spent/core/constants.dart';

final userPool = CognitoUserPool(AWS_COGNITO_USERPOOL_ID, AWS_COGNITO_CLIENT_ID);

@injectable
class AuthenticationRepository {
  final AuthenticationRemoteDataSource _authenticationRemoteDataSource;
  final AuthenticationLocalDataSource _authenticationLocalDataSource;

  const AuthenticationRepository(this._authenticationRemoteDataSource, this._authenticationLocalDataSource);

  Future<Token> getToken({String authCode}) async {
    final localToken = await _authenticationLocalDataSource.getToken();
    if (localToken != null) return localToken;

    final token = await _authenticationRemoteDataSource.getToken(authCode: authCode);
    return token;
  }

  Future<void> saveTokenToStorage(Token token) async {
    await _authenticationLocalDataSource.saveToken(token);
  }

  Future<void> removeTokenFromStorage() async {
    await _authenticationLocalDataSource.removeToken();
  }

  Future<User> getUserFromToken(Token token) async {
    final idToken = CognitoIdToken(token.idToken);
    final accessToken = CognitoAccessToken(token.accessToken);
    final refreshToken = CognitoRefreshToken(token.refreshToken);
    final session = CognitoUserSession(
      idToken,
      accessToken,
      refreshToken: refreshToken,
    );
    final cognitoUser = CognitoUser(null, userPool, signInUserSession: session);
    final user = await _getUserFromCognitoUser(cognitoUser);
    return user;
  }

  Future<User> getUserFromSession() async {
    final token = await getToken();
    if (token == null) return null;

    final cognitoUser = CognitoUser(null, userPool);
    final refreskToken = CognitoRefreshToken(token.refreshToken);
    await cognitoUser.refreshSession(refreskToken);
    final user = await _getUserFromCognitoUser(cognitoUser);
    return user;
  }

  Future<User> _getUserFromCognitoUser(CognitoUser cognitoUser) async {
    final userAttributes = await cognitoUser.getUserAttributes();
    final User user = User.fromCognitoAttributes(userAttributes);
    return user;
  }
}
