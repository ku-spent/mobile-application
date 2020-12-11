import 'package:amazon_cognito_identity_dart_2/cognito.dart';
import 'package:amazon_cognito_identity_dart_2/sig_v4.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spent/data/data_source/authentication/authentication_remote_data_source.dart';
import 'package:spent/data/data_source/user_storage/user_storage.dart';
import 'package:spent/data/http_manager/app_http_manager.dart';
import 'package:spent/di/di.dart';
import 'package:spent/domain/model/token.dart';
import 'package:spent/domain/model/user.dart';
import 'package:spent/core/constants.dart';

final userPool = CognitoUserPool(AWS_COGNITO_USERPOOL_ID, AWS_COGNITO_CLIENT_ID);
final credentials = CognitoCredentials(AWS_IDENTITY_POOL_ID, userPool);

@singleton
class AuthenticationRepository {
  final AuthenticationRemoteDataSource _authenticationRemoteDataSource;
  final AppHttpManager _httpManager;

  CognitoUserPool _userPool;
  CognitoUser _cognitoUser;
  CognitoUserSession _session;

  AuthenticationRepository(this._authenticationRemoteDataSource, this._httpManager);

  Future<bool> init() async {
    _userPool = userPool;
    final prefs = await SharedPreferences.getInstance();
    final storage = getIt<UserStorage>(param1: prefs);
    _userPool.storage = storage;

    _cognitoUser = await _userPool.getCurrentUser();
    if (_cognitoUser == null) {
      return false;
    }
    _session = await _cognitoUser.getSession();
    await setRemoteAuthFromSession();
    return _session.isValid();
  }

  Future<void> setRemoteAuthFromSession() async {
    _httpManager.accessToken = _session.accessToken.getJwtToken();
  }

  Future<AwsSigV4Client> getAwsSigV4Client() async {
    if (!isValidSession()) return null;
    await credentials.getAwsCredentials(_session.getIdToken().getJwtToken());
    final awsSigV4Client = AwsSigV4Client(
      credentials.accessKeyId,
      credentials.secretAccessKey,
      ENDPOINT,
      sessionToken: credentials.sessionToken,
      region: AWS_REGION,
    );
    return awsSigV4Client;
  }

  bool isValidSession() {
    if (_cognitoUser == null || _session == null) {
      return false;
    }

    if (!_session.isValid()) {
      return false;
    }

    return true;
  }

  /// Get existing user from session with his/her attributes
  Future<User> getCurrentUser() async {
    if (!isValidSession()) return null;

    final attributes = await _cognitoUser.getUserAttributes();
    if (attributes == null) {
      return null;
    }
    final user = await _getUserFromCognitoUser(_cognitoUser);
    return user;
  }

  Future<Token> getTokenFromAuthCoe({String authCode}) async {
    final token = await _authenticationRemoteDataSource.getToken(authCode: authCode);
    return token;
  }

  Future<User> getUserFromToken(Token token) async {
    final idToken = CognitoIdToken(token.idToken);
    final accessToken = CognitoAccessToken(token.accessToken);
    final refreshToken = CognitoRefreshToken(token.refreshToken);

    _session = CognitoUserSession(
      idToken,
      accessToken,
      refreshToken: refreshToken,
    );

    _cognitoUser = CognitoUser(idToken.jwtToken, userPool, signInUserSession: _session, storage: _userPool.storage);
    await _cognitoUser.cacheTokens();
    final user = await _getUserFromCognitoUser(_cognitoUser);
    return user;
  }

  Future<void> signOut() async {
    if (_cognitoUser != null) {
      return _cognitoUser.signOut();
    }
  }

  Future<User> getUserFromSession(Token token) async {
    final cognitoUser = await userPool.getCurrentUser();
    final user = await _getUserFromCognitoUser(cognitoUser);
    return user;
  }

  Future<User> _getUserFromCognitoUser(CognitoUser cognitoUser) async {
    final userAttributes = await cognitoUser.getUserAttributes();
    final User user = User.fromCognitoAttributes(userAttributes);
    return user;
  }
}
