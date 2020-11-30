import 'dart:convert';

import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spent/data/data_source/authentication/authentication_data_source.dart';
import 'package:spent/domain/model/token.dart';

// @Injectable(as: AuthenticationDataSource)
class AuthenticationLocalDataSource implements AuthenticationDataSource {
  static const String tokenKey = 'token';

  const AuthenticationLocalDataSource();

  @override
  Future<Token> getToken({String authCode}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Token token = Token.fromJson(jsonDecode(prefs.getString(tokenKey)));
    return token;
  }

  @override
  Future<void> saveToken(Token token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String stringifyToken = jsonEncode(token.toJson());
    await prefs.setString(tokenKey, stringifyToken);
  }
}
