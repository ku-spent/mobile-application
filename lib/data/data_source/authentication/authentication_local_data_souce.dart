import 'dart:convert';

import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spent/domain/model/token.dart';

// @Injectable(as: AuthenticationDataSource)
@injectable
class AuthenticationLocalDataSource {
  static const String tokenKey = 'token';

  const AuthenticationLocalDataSource();

  Future<Token> getToken({String authCode}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String localToken = prefs.getString(tokenKey);
    if (localToken == null) return null;

    Token token = Token.fromJson(jsonDecode(localToken));
    return token;
  }

  Future<void> saveToken(Token token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String stringifyToken = jsonEncode(token.toJson());
    await prefs.setString(tokenKey, stringifyToken);
  }

  Future<void> removeToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(tokenKey);
  }
}
