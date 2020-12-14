import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_core/amplify_core.dart';
import 'package:injectable/injectable.dart';
import 'package:spent/data/repository/authentication_repository.dart';
import 'package:spent/domain/model/token.dart';

@injectable
class InitialAuthenticationUseCase {
  final AuthenticationRepository _authenticationRepository;

  InitialAuthenticationUseCase(this._authenticationRepository);

  Future<bool> call() async {
    try {
      print('initial authentication');
      final isConfigured = await _authenticationRepository.init();
      await Future.delayed(const Duration(milliseconds: 400), () => {});
      print('initial authentication usecase $isConfigured');
      if (isConfigured) {
        final CognitoAuthSession cognitoAuthSession =
            await Amplify.Auth.fetchAuthSession(options: CognitoSessionOptions(getAWSCredentials: true));
        final token = Token(
          idToken: cognitoAuthSession.userPoolTokens.idToken,
          accessToken: cognitoAuthSession.userPoolTokens.accessToken,
          refreshToken: cognitoAuthSession.userPoolTokens.refreshToken,
        );
        await _authenticationRepository.setUserSessionFromToken(token);
        final user = await _authenticationRepository.getUserFromSession();
        print('user $user');
        if (user != null) {
          await _authenticationRepository.cacheToken();
          await _authenticationRepository.setRemoteAuthFromSession();
        }
      } else {
        // await _authenticationRepository.signOut();
      }
      return isConfigured;
    } catch (err) {
      print(err);
      // return false;
    }
  }
}
