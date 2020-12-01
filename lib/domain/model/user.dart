import 'package:amazon_cognito_identity_dart_2/cognito.dart';
import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String name;
  final String email;
  final String picture;
  final CognitoUser cognitoUser;

  User({this.name, this.email, this.picture, this.cognitoUser});

  factory User.fromJson(Map<String, String> user, CognitoUser cognitoUser) {
    return User(
      name: user['name'] ?? '',
      email: user['email'] ?? '',
      picture: user['picture'] ?? '',
      cognitoUser: cognitoUser,
    );
  }

  @override
  List<Object> get props => [name, email, picture];
}
