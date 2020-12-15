import 'package:amazon_cognito_identity_dart_2/cognito.dart';
import 'package:amazon_cognito_identity_dart_2/sig_v4.dart';
import 'package:amplify_analytics_pinpoint/amplify_analytics_pinpoint.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_core/amplify_core.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spent/amplifyconfiguration.dart';
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

  bool _amplifyConfigured = false;
  Amplify amplifyInstance = Amplify();

  CognitoUserPool _userPool;
  CognitoUser _cognitoUser;
  CognitoUserSession _session;

  AuthenticationRepository(this._authenticationRemoteDataSource, this._httpManager);

  Future<bool> init() async {
    await _configureAmplify();
    await _configureCognitoUser();
    return _amplifyConfigured;
    // return _session.isValid();

    // final isSignedIn = authSession.isSignedIn;
    // return isSignedIn;
  }

  Future<void> _configureAmplify() async {
    // Add Pinpoint and Cognito Plugins, or any other plugins you want to use
    AmplifyAuthCognito authPlugin = AmplifyAuthCognito();
    AmplifyAnalyticsPinpoint analyticsPlugin = AmplifyAnalyticsPinpoint();

    amplifyInstance.addPlugin(authPlugins: [authPlugin], analyticsPlugins: [analyticsPlugin]);

    // Once Plugins are added, configure Amplify
    await amplifyInstance.configure(amplifyconfig);
    _amplifyConfigured = true;
    print('configured amplify');
  }

  Future<void> _configureCognitoUser() async {
    _userPool = userPool;
    final prefs = await SharedPreferences.getInstance();
    final storage = getIt<UserStorage>(param1: prefs);
    _userPool.storage = storage;

    final CognitoAuthSession cognitoAuthSession = await Amplify.Auth.fetchAuthSession(
      options: CognitoSessionOptions(getAWSCredentials: true),
    );

    final token = Token(
      idToken: cognitoAuthSession.userPoolTokens.idToken,
      accessToken: cognitoAuthSession.userPoolTokens.accessToken,
      refreshToken: cognitoAuthSession.userPoolTokens.refreshToken,
    );
    await setUserSessionFromToken(token);
    print('configured cognitoUser');
  }

  Future<void> setRemoteAuthFromSession() async {
    _httpManager.accessToken = _session.accessToken.getJwtToken();
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

  Future<User> getUserFromSession() async {
    final user = await _getUserFromCognitoUser(_cognitoUser);
    return user;
  }

  Future<void> setUserSessionFromToken(Token token) async {
    final idToken = CognitoIdToken(token.idToken);
    final accessToken = CognitoAccessToken(token.accessToken);
    final refreshToken = CognitoRefreshToken(token.refreshToken);

    _session = CognitoUserSession(
      idToken,
      accessToken,
      refreshToken: refreshToken,
    );

    _cognitoUser = CognitoUser(idToken.jwtToken, userPool, signInUserSession: _session, storage: _userPool.storage);
  }

  Future<void> cacheToken() async {
    await _cognitoUser.cacheTokens();
  }

  Future<void> signOut() async {
    if (_cognitoUser != null) {
      await _cognitoUser.signOut();
    }
    _session.invalidateToken();
    await Amplify.Auth.signOut(options: CognitoSignOutOptions(globalSignOut: true));
  }

  Future<User> _getUserFromCognitoUser(CognitoUser cognitoUser) async {
    final userAttributes = await cognitoUser.getUserAttributes();
    final User user = User.fromCognitoAttributes(userAttributes);
    return user;
  }

  // Future<AwsSigV4Client> getAwsSigV4Client() async {
  //   if (!isValidSession()) return null;
  //   await credentials.getAwsCredentials(_session.getIdToken().getJwtToken());
  //   final awsSigV4Client = AwsSigV4Client(
  //     credentials.accessKeyId,
  //     credentials.secretAccessKey,
  //     'https://8ovk4f09tf.execute-api.ap-southeast-1.amazonaws.com/dev',
  //     sessionToken: credentials.sessionToken,
  //     region: AWS_REGION,
  //   );
  //   return awsSigV4Client;
  // }

  // Future<User> getUserFromSession(Token token) async {
  //   final cognitoUser = await userPool.getCurrentUser();
  //   final user = await _getUserFromCognitoUser(cognitoUser);
  //   return user;
  // }

}
