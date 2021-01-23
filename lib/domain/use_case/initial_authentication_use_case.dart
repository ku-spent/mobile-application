import 'package:injectable/injectable.dart';
import 'package:spent/data/repository/authentication_repository.dart';

@injectable
class InitialAuthenticationUseCase {
  final AuthenticationRepository _authenticationRepository;

  const InitialAuthenticationUseCase(this._authenticationRepository);

  Future<bool> call() async {
    try {
      print('initial authentication');
      final isConfigured = await _authenticationRepository.initAmplify();
      bool isLogin = await _authenticationRepository.isLogin();
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
    } catch (err) {
      print(err);
      // bool isLogin = await _authenticationRepository.isLogin();
      // print('offline login $isLogin');
      // return isLogin;
    }
  }
}
