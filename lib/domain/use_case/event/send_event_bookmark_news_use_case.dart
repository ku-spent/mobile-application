import 'package:amplify_analytics_pinpoint/amplify_analytics_pinpoint.dart';
import 'package:amplify_flutter/amplify.dart';
import 'package:injectable/injectable.dart';
import 'package:spent/domain/model/News.dart';
import 'package:spent/domain/model/send_event.dart';

@injectable
class SendEventBookmarkNewsUseCase {
  const SendEventBookmarkNewsUseCase();

  Future<void> call(News news) async {
    AnalyticsEvent analyticsEvent = AnalyticsEvent(SendEvent.bookmarkNewsEvent);
    analyticsEvent.properties.addStringProperty("news_id", news.id);
    await Amplify.Analytics.recordEvent(event: analyticsEvent);
  }
}