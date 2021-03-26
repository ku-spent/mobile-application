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
import 'package:spent/domain/model/ModelProvider.dart';

final String isLoginKey = 'IS_LOGIN';
final String userBoxName = 'USER_BOX';

@singleton
class AuthenticationRepository {
  final AuthenticationRemoteDataSource _authenticationRemoteDataSource;

  bool _amplifyConfigured = false;

  User _user;

  AuthenticationRepository(this._authenticationRemoteDataSource);

  Future<bool> initAmplify() async {
    try {
      await _configureAmplify();
      return _amplifyConfigured;
    } on AmplifyAlreadyConfiguredException {
      print('amplify already configured');
      return true;
    } catch (e) {}
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

  Future<bool> isLogin() async {
    final userBox = await Hive.openBox(userBoxName);
    final bool isLogin = userBox.get(isLoginKey);
    return isLogin;
  }

  /// Get existing user from session with his/her attributes
  Future<User> getCurrentUser() async {
    // cache
    if (_user != null) {
      print('use cache user');
      return _user;
    }
    final User user = await initialUser();
    return user;
  }

  Future<User> initialUser() async {
    final Map<String, String> userMap = await getUserMap();
    print('initialUser $userMap');
    final User user = User(
      id: userMap['sub'],
      name: userMap['name'],
      email: userMap['email'],
      picture: userMap['picture'],
    );
    _user = user;
    return user;
  }

  Future<Map<String, String>> getUserMap() async {
    final res = await Amplify.Auth.fetchUserAttributes();
    final Map<String, String> userMap = {'name': '', 'email': '', 'picture': '', 'sub': ''};
    for (AuthUserAttribute attribute in res) {
      if (userMap.containsKey(attribute.userAttributeKey)) {
        userMap[attribute.userAttributeKey] = attribute.value;
      }
    }
    return userMap;
  }

  Future<Token> getTokenFromAuthCoe({String authCode}) async {
    final token = await _authenticationRemoteDataSource.getToken(authCode: authCode);
    return token;
  }

  Future<void> cacheLogin() async {
    final userBox = await Hive.openBox(userBoxName);
    await userBox.put(isLoginKey, true);
  }

  Future<void> signOut() async {
    await Amplify.Auth.signOut();
    await Amplify.DataStore.clear();
    _user = null;
    print('clear');
    final userBox = await Hive.openBox(userBoxName);
    await userBox.put(isLoginKey, false);
  }
}
