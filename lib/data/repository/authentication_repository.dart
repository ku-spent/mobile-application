import 'package:amazon_cognito_identity_dart_2/cognito.dart';
import 'package:injectable/injectable.dart';
import 'package:spent/data/data_source/authentication/authentication_data_source.dart';
import 'package:spent/domain/model/token.dart';
import 'package:spent/domain/model/user.dart';

@injectable
class AuthenticationRepository {
  final AuthenticationDataSource _authenticationDataSource;

  const AuthenticationRepository(this._authenticationDataSource);

  Future<Token> getToken(String authCode) async {
    try {
      final token = await _authenticationDataSource.getToken(authCode: authCode);
      return token;
    } catch (e) {
      print(e);
    }
  }

  Future<void> saveTokenToStorage(Token token) async {}

  Future<User> getUserFromToken(Token token) async {
    try {
      final userPool = CognitoUserPool('ap-southeast-1_QweZctSpb', '4mj6hk0jnb4jmjdisonmkprq33');
      final idToken = CognitoIdToken(token.idToken);
      final accessToken = CognitoAccessToken(token.accessToken);
      final refreshToken = CognitoRefreshToken(token.refreshToken);
      final session = CognitoUserSession(
        idToken,
        accessToken,
        refreshToken: refreshToken,
      );
      final cognitoUser = CognitoUser(null, userPool, signInUserSession: session);
      Map<String, String> attMap = {'name': '', 'email': '', 'picture': ''};
      for (CognitoUserAttribute attribute in await cognitoUser.getUserAttributes()) {
        if (attMap.containsKey(attribute.name)) {
          attMap[attribute.name] = attribute.value;
        }
      }
      final User user = User.fromJson(attMap);
      return user;
    } catch (e) {
      print('error');
      print(e);
    }
  }
}
