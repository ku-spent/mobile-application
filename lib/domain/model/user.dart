import 'package:amazon_cognito_identity_dart_2/cognito.dart';
import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String id;
  final String name;
  final String email;
  final String picture;

  User({this.id, this.name, this.email, this.picture});

  factory User.fromCognitoAttributes(List<CognitoUserAttribute> cognitoAttributes) {
    Map<String, String> user = {'name': '', 'email': '', 'picture': '', 'sub': ''};
    for (CognitoUserAttribute attribute in cognitoAttributes) {
      if (user.containsKey(attribute.name)) {
        user[attribute.name] = attribute.value;
      }
    }
    return User(
      id: user['sub'] ?? '',
      name: user['name'] ?? '',
      email: user['email'] ?? '',
      picture: user['picture'] ?? '',
    );
  }

  @override
  List<Object> get props => [name, email, picture];
}
