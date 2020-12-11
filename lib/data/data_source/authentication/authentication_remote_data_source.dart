import 'package:injectable/injectable.dart';
import 'package:spent/core/constants.dart';
import 'package:spent/data/data_source/authentication/authentication_data_source.dart';
import 'package:spent/data/http_manager/app_http_manager.dart';
import 'package:spent/domain/model/token.dart';

@injectable
class AuthenticationRemoteDataSource implements AuthenticationDataSource {
  final AppHttpManager _httpManager;

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
        'client_id': AWS_COGNITO_CLIENT_ID,
        'code': authCode,
        'redirect_uri': 'myapp://'
      },
    );
    return Token.fromJson(response);
  }

  // @override
  // Future<Token> saveToken(Token token) async {
  //   // TODO
  // }
}
