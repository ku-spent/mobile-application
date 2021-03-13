import 'package:injectable/injectable.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';

import 'package:spent/data/repository/authentication_repository.dart';

@injectable
class InitialAuthenticationUseCase {
  final AuthenticationRepository _authenticationRepository;

  const InitialAuthenticationUseCase(this._authenticationRepository);

  Future<bool> call() async {
    try {
      print('initial authentication');
      final isConfigured = await _authenticationRepository.initAmplify();
      final bool isLogin = await _authenticationRepository.isLogin();
      if (!isLogin) return false;
      await Future.delayed(const Duration(milliseconds: 400), () => {});
      print('initial authentication usecase $isConfigured');
      if (isConfigured) {
        await _authenticationRepository.initCognito();
        final user = await _authenticationRepository.getCurrentUser();
        print('user $user');
        if (user != null) {
          await _authenticationRepository.cacheToken();
          await _authenticationRepository.setRemoteAuthFromSession();
        }
      }
      return isConfigured;
    } on SessionExpiredException {
      return false;
    } catch (err) {
      print(err);
    }
  }
}
