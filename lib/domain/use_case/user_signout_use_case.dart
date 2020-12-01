import 'package:injectable/injectable.dart';
import 'package:spent/data/repository/authentication_repository.dart';

@injectable
class UserSignOutUseCase {
  final AuthenticationRepository _authenticationRepository;

  const UserSignOutUseCase(this._authenticationRepository);

  Future<void> call() async {
    try {
      final token = await _authenticationRepository.getToken();
      final user = await _authenticationRepository.getUserFromSession(token);

      await user.cognitoUser.signOut();
      await _authenticationRepository.removeTokenFromStorage();
    } catch (err) {
      print(err);
    }
  }
}
