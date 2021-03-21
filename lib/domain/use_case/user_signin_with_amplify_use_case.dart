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
      SignInResult result = await Amplify.Auth.signInWithWebUI(provider: AuthProvider.google);
      if (!result.isSignedIn)
        return null;
      else {
        await _authenticationRepository.initCognito();
        String userId = _authenticationRepository.getUserId();
        bool hasUser = await _authenticationRepository.hasUser(userId);
        if (!hasUser) {
          // if not has user in database
          print('Not found user');
          print('Create new user');
          Map<String, String> userMap = await _authenticationRepository.getUserMap();
          await _authenticationRepository.createUser(userMap);
        }
        final user = await _authenticationRepository.getCurrentUser();
        print(user);
        if (user != null) {
          await _authenticationRepository.cacheToken();
          await _authenticationRepository.setRemoteAuthFromSession();
        }
        return user;
      }
    } catch (err) {
      print(err);
    }
  }
}
