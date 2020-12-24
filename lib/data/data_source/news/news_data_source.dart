import 'package:spent/domain/model/News.dart';

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
