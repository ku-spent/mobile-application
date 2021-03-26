import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify.dart';
import 'package:injectable/injectable.dart';
import 'package:spent/data/repository/authentication_repository.dart';
import 'package:spent/domain/model/User.dart';

@injectable
class UserSignInWithAmplifyUseCase {
  final AuthenticationRepository _authenticationRepository;

  const UserSignInWithAmplifyUseCase(this._authenticationRepository);

  Future<User> call() async {
    try {
      final SignInResult result = await Amplify.Auth.signInWithWebUI(provider: AuthProvider.google);
      if (!result.isSignedIn)
        return null;
      else {
        final User user = await _authenticationRepository.initialUser();
        await _authenticationRepository.cacheLogin();
        return user;
      }
    } catch (err) {
      print(err);
    }
  }
}
