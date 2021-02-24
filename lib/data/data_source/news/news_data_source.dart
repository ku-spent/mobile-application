import 'package:spent/domain/model/News.dart';
import 'package:spent/domain/model/Recommendation.dart';

abstract class NewsDataSource {
  Future<Recommendation> getRecommendations(String userId);

  Future<List<News>> getFeeds(
    int from,
    int size,
    String queryField,
    String query,
  );

  Future<List<News>> getSuggestionNews(
    int from,
    int size,
    News curNews,
  );

  Future<News> getNewsById(
    String id,
  );
}
