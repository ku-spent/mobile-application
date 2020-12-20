import 'package:injectable/injectable.dart';
import 'package:spent/data/repository/authentication_repository.dart';
import 'package:spent/domain/model/User.dart';

@injectable
class GetCurrentUserUseCase {
  final AuthenticationRepository _authenticationRepository;

  GetCurrentUserUseCase(this._authenticationRepository);

  Future<User> call() async {
    try {
      final isValidSession = _authenticationRepository.isValidSession();
      if (!isValidSession) return null;

      final user = await _authenticationRepository.getCurrentUser();
      return user;
    } catch (err) {
      print(err);
    }
  }
}
