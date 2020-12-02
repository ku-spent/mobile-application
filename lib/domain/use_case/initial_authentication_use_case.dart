import 'package:injectable/injectable.dart';
import 'package:spent/data/repository/authentication_repository.dart';

@injectable
class InitialAuthenticationUseCase {
  final AuthenticationRepository _authenticationRepository;

  InitialAuthenticationUseCase(this._authenticationRepository);

  Future<bool> call() async {
    try {
      final isValid = await _authenticationRepository.init();
      return isValid;
    } catch (err) {
      print(err);
    }
  }
}
