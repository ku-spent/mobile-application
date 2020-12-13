import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_core/amplify_core.dart';
import 'package:injectable/injectable.dart';
import 'package:spent/data/repository/authentication_repository.dart';
import 'package:spent/domain/model/token.dart';
import 'package:spent/domain/model/user.dart';

@injectable
class UserSignInWithAmplifyUseCase {
  final AuthenticationRepository _authenticationRepository;

  const UserSignInWithAmplifyUseCase(this._authenticationRepository);

  Future<User> call() async {
    try {
      final isSuccess = await Amplify.Auth.signInWithWebUI(provider: AuthProvider.google);
      if (!isSuccess)
        return null;
      else {
        final CognitoAuthSession cognitoAuthSession =
            await Amplify.Auth.fetchAuthSession(options: CognitoSessionOptions(getAWSCredentials: true));
        final token = Token(
          idToken: cognitoAuthSession.userPoolTokens.idToken,
          accessToken: cognitoAuthSession.userPoolTokens.accessToken,
          refreshToken: cognitoAuthSession.userPoolTokens.refreshToken,
        );
        final user = await _authenticationRepository.getUserFromToken(token);
        if (user != null) await _authenticationRepository.cacheToken();
        return user;
      }
    } catch (err) {
      print(err);
    }
  }
}
