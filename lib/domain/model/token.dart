import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class Token extends Equatable {
  final String idToken;
  final String accessToken;
  final String refreshToken;

  Token({
    @required this.idToken,
    @required this.accessToken,
    @required this.refreshToken,
  });

  factory Token.fromJson(Map<String, dynamic> token) {
    return Token(
      idToken: token['id_token'] ?? '',
      accessToken: token['access_token'] ?? '',
      refreshToken: token['refresh_token'] ?? '',
    );
  }

  Map toJson() => {
        'id_token': idToken,
        'access_token': accessToken,
        'refresh_token': refreshToken,
      };

  @override
  List<Object> get props => [idToken, accessToken, refreshToken];
}
