import 'package:amplify_core/amplify_core.dart';
import 'package:injectable/injectable.dart';
import 'package:spent/data/repository/authentication_repository.dart';

@injectable
class InitialAuthenticationUseCase {
  final AuthenticationRepository _authenticationRepository;

  InitialAuthenticationUseCase(this._authenticationRepository);

  Future<bool> call() async {
    try {
      final isConfigured = await _authenticationRepository.init();
      await Future.delayed(const Duration(milliseconds: 400), () => {});
      print('initial authentication usecase $isConfigured');
      if (isConfigured) {
        final authUser = await Amplify.Auth.getCurrentUser();
        if (authUser != null) await _authenticationRepository.setRemoteAuthFromSession();
      } else {
        await _authenticationRepository.signOut();
      }
      return isConfigured;
    } catch (err) {
      print(err);
      // return false;
    }
  }
}
