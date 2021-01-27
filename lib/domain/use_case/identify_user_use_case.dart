import 'package:amplify_flutter/amplify.dart';
import 'package:injectable/injectable.dart';
import 'package:amplify_analytics_pinpoint/amplify_analytics_pinpoint.dart';

import 'package:spent/data/repository/authentication_repository.dart';

@injectable
class IdentifyUserUseCase {
  final AuthenticationRepository _authenticationRepository;

  const IdentifyUserUseCase(this._authenticationRepository);

  Future<void> call() async {
    try {
      final isValidSession = _authenticationRepository.isValidSession();
      if (!isValidSession) return null;

      final user = await _authenticationRepository.getCurrentUser();

      AnalyticsUserProfile userProfile = new AnalyticsUserProfile();
      userProfile.name = user.name;
      userProfile.email = user.email;
      final userId = (await Amplify.Auth.getCurrentUser()).userId;

      Amplify.Analytics.identifyUser(userId: userId, userProfile: userProfile);
    } catch (e) {
      print(e);
    }
  }
}
