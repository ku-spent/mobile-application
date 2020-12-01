import 'package:injectable/injectable.dart';
import 'package:spent/core/constants.dart';
import 'package:spent/data/data_source/authentication/authentication_data_source.dart';
import 'package:spent/data/http_manager/http_manager.dart';
import 'package:spent/domain/model/token.dart';

@injectable
class AuthenticationRemoteDataSource implements AuthenticationDataSource {
  final HttpManager _httpManager;

  const AuthenticationRemoteDataSource(this._httpManager);

  @override
  Future<Token> getToken({String authCode}) async {
    final response = await _httpManager.post(
      endpoint: AUTH_ENDPOINT,
      path: '/token',
      body: {},
      headers: {'Content-Type': 'application/x-www-form-urlencoded'},
      query: {
        'grant_type': 'authorization_code',
        'client_id': '4mj6hk0jnb4jmjdisonmkprq33',
        'code': authCode,
        'redirect_uri': 'myapp://'
      },
    );
    return Token.fromJson(response);
  }

  @override
  Future<Token> saveToken(Token token) async {
    // TODO
  }
}
