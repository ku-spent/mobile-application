import 'package:spent/domain/model/news.dart';

abstract class NewsDataSource {
  Future<List<News>> getFeeds(
    int from,
    int size,
    String queryField,
    String query,
  );

  Future<News> getNewsById(
    String id,
  );
}
