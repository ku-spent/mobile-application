import 'package:injectable/injectable.dart';
import 'package:spent/data/repository/authentication_repository.dart';
import 'package:spent/domain/model/user.dart';

@injectable
class UserSignInWithAuthCodeUseCase {
  final AuthenticationRepository _authenticationRepository;

  const UserSignInWithAuthCodeUseCase(this._authenticationRepository);

  Future<User> call(String authCode) async {
    try {
      final token = await _authenticationRepository.getTokenFromAuthCoe(authCode: authCode);
      final user = await _authenticationRepository.getUserFromToken(token);
      await _authenticationRepository.setRemoteAuthFromSession();
      return user;
    } catch (err) {
      print(err);
    }
  }
}
