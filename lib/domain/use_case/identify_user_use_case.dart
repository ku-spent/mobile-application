import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify.dart';
import 'package:injectable/injectable.dart';
import 'package:amplify_analytics_pinpoint/amplify_analytics_pinpoint.dart';

import 'package:spent/data/repository/authentication_repository.dart';

@injectable
class IdentifyUserUseCase {
  final AuthenticationRepository _authenticationRepository;

  const IdentifyUserUseCase(this._authenticationRepository);

  Future<bool> call() async {
    try {
      final isValidSession = await _authenticationRepository.isValidSession();
      if (!isValidSession) return null;

      final user = await _authenticationRepository.getCurrentUser();

      AnalyticsUserProfile userProfile = new AnalyticsUserProfile();
      userProfile.name = user.name;
      userProfile.email = user.email;
      final userId = (await Amplify.Auth.getCurrentUser()).userId;

      Amplify.Analytics.identifyUser(userId: userId, userProfile: userProfile);

      final AnalyticsProperties globalProperties = AnalyticsProperties();
      globalProperties.addStringProperty('user_id', userId);
      Amplify.Analytics.registerGlobalProperties(globalProperties: globalProperties);

      return true;
    } on SessionExpiredException {
      return false;
    } catch (e) {
      print(e);
    }
  }
}
