import 'package:amazon_cognito_identity_dart_2/cognito.dart';
import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String name;
  final String email;
  final String picture;
  // final CognitoUser cognitoUser;

  User({this.name, this.email, this.picture});

  factory User.fromCognitoAttributes(List<CognitoUserAttribute> cognitoAttributes) {
    Map<String, String> user = {'name': '', 'email': '', 'picture': ''};
    for (CognitoUserAttribute attribute in cognitoAttributes) {
      if (user.containsKey(attribute.name)) {
        user[attribute.name] = attribute.value;
      }
    }
    return User(
      name: user['name'] ?? '',
      email: user['email'] ?? '',
      picture: user['picture'] ?? '',
      // cognitoUser: cognitoUser,
    );
  }

  @override
  List<Object> get props => [name, email, picture];
}
