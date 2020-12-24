import 'package:amplify_analytics_pinpoint/amplify_analytics_pinpoint.dart';
import 'package:amplify_core/amplify_core.dart';
import 'package:injectable/injectable.dart';
import 'package:spent/domain/model/News.dart';

@injectable
class SendEventViewNewsUseCase {
  const SendEventViewNewsUseCase();

  Future<void> call(News news) async {
    AnalyticsEvent analyticsEvent = AnalyticsEvent("view_news");
    analyticsEvent.properties.addStringProperty("news_id", news.id);
    await Amplify.Analytics.recordEvent(event: analyticsEvent);
  }
}
