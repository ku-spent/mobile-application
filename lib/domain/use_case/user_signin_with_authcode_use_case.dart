import 'package:injectable/injectable.dart';
import 'package:spent/data/repository/authentication_repository.dart';
import 'package:spent/domain/model/user.dart';

@injectable
class UserSignInWithAuthCodeUseCase {
  final AuthenticationRepository _authenticationRepository;

  const UserSignInWithAuthCodeUseCase(this._authenticationRepository);

  Future<User> call(String authCode) async {
    final token = await _authenticationRepository.getToken(authCode);
    final user = await _authenticationRepository.getUserFromToken(token);
    return user;
    // return Future.delayed(
    //   const Duration(milliseconds: 500),
    //   () => User(
    //     email: 'test@hotmail.com',
    //     name: 'test user',
    //     picture: 'testpic',
    //   ),
    // );
  }
}
