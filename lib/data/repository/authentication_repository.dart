import 'package:amazon_cognito_identity_dart_2/cognito.dart';
import 'package:amplify_analytics_pinpoint/amplify_analytics_pinpoint.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_core/amplify_core.dart';
import 'package:amplify_datastore/amplify_datastore.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spent/amplifyconfiguration.dart';
import 'package:spent/data/data_source/authentication/authentication_remote_data_source.dart';
import 'package:spent/data/data_source/local_storage/local_storage.dart';
import 'package:spent/data/http_manager/app_http_manager.dart';
import 'package:spent/di/di.dart';
import 'package:spent/domain/model/token.dart';
import 'package:spent/domain/model/User.dart';
import 'package:spent/core/constants.dart';
import 'package:spent/domain/model/ModelProvider.dart';

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
  User _user;

  AuthenticationRepository(this._authenticationRemoteDataSource, this._httpManager);

  Future<bool> init() async {
    await _configureAmplify();
    await _configureCognitoUser();
    return _amplifyConfigured;
  }

  Future<void> _configureAmplify() async {
    // Add Pinpoint and Cognito Plugins, or any other plugins you want to use
    AmplifyAuthCognito authPlugin = AmplifyAuthCognito();
    AmplifyAnalyticsPinpoint analyticsPlugin = AmplifyAnalyticsPinpoint();
    AmplifyDataStore datastorePlugin = AmplifyDataStore(modelProvider: ModelProvider.instance);
    amplifyInstance.addPlugin(
      authPlugins: [authPlugin],
      analyticsPlugins: [analyticsPlugin],
      dataStorePlugins: [datastorePlugin],
    );

    authPlugin.events.listenToAuth((hubEvent) {
      switch (hubEvent["eventName"]) {
        case "SIGNED_IN":
          {
            print("USER IS SIGNED IN");
          }
          break;
        case "SIGNED_OUT":
          {
            Amplify.DataStore.clear();
            print("USER IS SIGNED OUT");
          }
          break;
        case "SESSION_EXPIRED":
          {
            print("USER IS SIGNED IN");
          }
          break;
      }
    });

    amplifyInstance.configure(amplifyconfig);
    // Amplify.DataStore.clear();
    _amplifyConfigured = true;
    print('configured amplify');
  }

  Future<void> _configureCognitoUser() async {
    _userPool = userPool;
    final prefs = await SharedPreferences.getInstance();
    final storage = getIt<LocalStorage>(param1: prefs);
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
    // cache
    if (_user != null) return _user;
    String userId = _session.idToken.payload['sub'];
    User user = (await Amplify.DataStore.query(
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
    String userId = _session.idToken.payload['sub'];
    return userId;
  }

  Future<Map<String, String>> getUserMap() async {
    final cognitoAttributes = await _cognitoUser.getUserAttributes();
    Map<String, String> userMap = {'name': '', 'email': '', 'picture': '', 'sub': ''};
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

  // Future<User> getUserFromSession() async {
  //   final user = await _getUserFromCognitoUser(_cognitoUser);
  //   return user;
  // }

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

  // Future<User> _getUserFromCognitoUser(CognitoUser cognitoUser) async {
  //   final userAttributes = await cognitoUser.getUserAttributes();
  //   final User user = User.fromCognitoAttributes(userAttributes);
  //   return user;
  // }

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
