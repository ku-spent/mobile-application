import 'package:amplify_analytics_pinpoint/amplify_analytics_pinpoint.dart';
import 'package:amplify_flutter/amplify.dart';
import 'package:injectable/injectable.dart';
import 'package:spent/domain/model/News.dart';
import 'package:spent/domain/model/send_event.dart';

@injectable
class SendEventShareNewsUseCase {
  const SendEventShareNewsUseCase();

  Future<void> call(News news, {String recommendationId}) async {
    AnalyticsEvent analyticsEvent = AnalyticsEvent(SendEvent.shareNewsEvent);
    analyticsEvent.properties.addStringProperty("news_id", news.id);
    if (recommendationId != null) analyticsEvent.properties.addStringProperty("recommendation_id", recommendationId);
    await Amplify.Analytics.recordEvent(event: analyticsEvent);
  }
}
