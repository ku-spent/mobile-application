import 'package:amplify_analytics_pinpoint/amplify_analytics_pinpoint.dart';
import 'package:injectable/injectable.dart';

@injectable
class UserEventRepository {
  const UserEventRepository();

  Future<void> sendReadNewsEvent(String url) async {
    final AnalyticsEvent event = AnalyticsEvent("PasswordReset");
    event.properties.addStringProperty("url", url);
  }
}
