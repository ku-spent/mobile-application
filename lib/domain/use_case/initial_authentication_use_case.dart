import 'package:injectable/injectable.dart';
import 'package:spent/data/repository/authentication_repository.dart';
import 'package:spent/data/repository/user_repository.dart';

@injectable
class InitialAuthenticationUseCase {
  final AuthenticationRepository _authenticationRepository;

  const InitialAuthenticationUseCase(this._authenticationRepository);

  Future<bool> call() async {
    try {
      print('initial authentication');
      final isConfigured = await _authenticationRepository.init();
      await Future.delayed(const Duration(milliseconds: 400), () => {});
      print('initial authentication usecase $isConfigured');
      if (isConfigured) {
        final user = await _authenticationRepository.getCurrentUser();
        print('user $user');
        if (user != null) {
          await _authenticationRepository.cacheToken();
          await _authenticationRepository.setRemoteAuthFromSession();
        }
      }
      return isConfigured;
    } catch (err) {
      print(err);
      // return false;
    }
  }
}
