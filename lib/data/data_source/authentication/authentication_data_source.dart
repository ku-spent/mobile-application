import 'package:spent/domain/model/token.dart';

abstract class AuthenticationDataSource {
  Future<Token> getToken({String authCode});
  // Future<void> saveToken(Token token);
}
