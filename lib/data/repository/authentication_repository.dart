import 'package:amazon_cognito_identity_dart_2/cognito.dart';
import 'package:amplify_analytics_pinpoint/amplify_analytics_pinpoint.dart';
import 'package:amplify_flutter/amplify.dart';
import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_datastore/amplify_datastore.dart';
import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';

import 'package:spent/amplifyconfiguration.dart';
import 'package:spent/data/data_source/authentication/authentication_remote_data_source.dart';
import 'package:spent/data/http_manager/app_http_manager.dart';
import 'package:spent/domain/model/token.dart';
import 'package:spent/domain/model/User.dart';
import 'package:spent/core/constants.dart';
import 'package:spent/domain/model/ModelProvider.dart';

final userPool = CognitoUserPool(AWS_COGNITO_USERPOOL_ID, AWS_COGNITO_CLIENT_ID);
final credentials = CognitoCredentials(AWS_IDENTITY_POOL_ID, userPool);

final String isLoginKey = 'IS_LOGIN';
final String userBoxName = 'USER_BOX';

@singleton
class AuthenticationRepository {
  final AuthenticationRemoteDataSource _authenticationRemoteDataSource;
  final AppHttpManager _httpManager;

  bool _amplifyConfigured = false;
  // AmplifyClass amplifyInstance = Amplify;

  CognitoUserPool _userPool;
  CognitoUser _cognitoUser;
  CognitoUserSession _session;
  User _user;

  AuthenticationRepository(this._authenticationRemoteDataSource, this._httpManager);

  Future<bool> initAmplify() async {
    try {
      await _configureAmplify();
      return _amplifyConfigured;
    } on AmplifyAlreadyConfiguredException {
      print('amplify already configured');
      return true;
    } catch (e) {}
  }

  Future<void> initCognito() async {
    await _configureCognitoUser();
  }

  Future<void> _configureAmplify() async {
    // Add Pinpoint and Cognito Plugins, or any other plugins you want to use
    final AmplifyAPI api = AmplifyAPI();
    final AmplifyAuthCognito authPlugin = AmplifyAuthCognito();
    final AmplifyAnalyticsPinpoint analyticsPlugin = AmplifyAnalyticsPinpoint();
    final AmplifyDataStore datastorePlugin = AmplifyDataStore(modelProvider: ModelProvider.instance);

    await Amplify.addPlugins([authPlugin, analyticsPlugin, datastorePlugin, api]);

    await Amplify.configure(amplifyconfig);

    _amplifyConfigured = true;
    print('configured amplify');
  }

  Future<void> _configureCognitoUser() async {
    _userPool = userPool;

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

  Future<bool> isLogin() async {
    final userBox = await Hive.openBox(userBoxName);
    final bool isLogin = userBox.get(isLoginKey);
    return isLogin;
  }

  Future<void> setRemoteAuthFromSession() async {
    _httpManager.accessToken = _session.accessToken.getJwtToken();
  }

  Future<bool> isValidSession() async {
    if (_cognitoUser == null || _session == null) {
      return false;
    }

    if (!_session.isValid()) {
      _session = await _cognitoUser.refreshSession(_session.refreshToken);
      return _session.isValid();
    }

    return true;
  }

  /// Get existing user from session with his/her attributes
  Future<User> getCurrentUser() async {
    // cache
    if (_user != null) {
      print('use cache user');
      return _user;
    }
    final String userId = _session.idToken.payload['sub'];
    final User user = (await Amplify.DataStore.query(
      User.classType,
      where: User.ID.eq(userId),
    ))[0];
    _user = user;
    return user;
  }

  Future<bool> hasUser(String userId) async {
    final users = await Amplify.DataStore.query(
      User.classType,
      where: User.ID.eq(userId),
    );
    return users.isNotEmpty;
  }

  String getUserId() {
    final String userId = _session.idToken.payload['sub'];
    return userId;
  }

  Future<Map<String, String>> getUserMap() async {
    final cognitoAttributes = await _cognitoUser.getUserAttributes();
    final Map<String, String> userMap = {'name': '', 'email': '', 'picture': '', 'sub': ''};
    for (CognitoUserAttribute attribute in cognitoAttributes) {
      if (userMap.containsKey(attribute.name)) {
        userMap[attribute.name] = attribute.value;
      }
    }
    return userMap;
  }

  Future<void> createUser(Map<String, String> userMap) async {
    final user = User(
      id: userMap['sub'],
      name: userMap['name'],
      email: userMap['email'],
      picture: userMap['picture'],
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
    await Amplify.DataStore.save(user);
  }

  Future<Token> getTokenFromAuthCoe({String authCode}) async {
    final token = await _authenticationRemoteDataSource.getToken(authCode: authCode);
    return token;
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
    final userBox = await Hive.openBox(userBoxName);
    await userBox.put(isLoginKey, true);
    await _cognitoUser.cacheTokens();
  }

  Future<void> signOut() async {
    await Amplify.Auth.signOut();
    await Amplify.DataStore.clear();
    if (_cognitoUser != null) {
      // await _cognitoUser.signOut();
      await _cognitoUser.globalSignOut();
    }
    _cognitoUser = null;
    _userPool = null;
    _session = null;
    _user = null;
    print('clear');
    final userBox = await Hive.openBox(userBoxName);
    await userBox.put(isLoginKey, false);
    // _session.invalidateToken();
  }
}
