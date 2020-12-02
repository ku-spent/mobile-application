import 'package:injectable/injectable.dart';
import 'package:spent/data/repository/authentication_repository.dart';

@injectable
class UserSignOutUseCase {
  final AuthenticationRepository _authenticationRepository;

  const UserSignOutUseCase(this._authenticationRepository);

  Future<void> call() async {
    try {
      await _authenticationRepository.signOut();
    } catch (err) {
      print(err);
    }
  }
}
