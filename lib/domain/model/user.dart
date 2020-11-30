import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String name;
  final String email;
  final String picture;

  const User({this.name, this.email, this.picture});

  factory User.fromJson(Map<String, String> user) {
    return User(
      name: user['name'] ?? '',
      email: user['email'] ?? '',
      picture: user['picture'] ?? '',
    );
  }

  @override
  List<Object> get props => [name, email, picture];
}
