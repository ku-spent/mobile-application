import 'package:injectable/injectable.dart';
import 'package:spent/data/data_source/news/news_data_source.dart';
import 'package:spent/domain/model/news.dart';

@injectable
class NewsRepository {
  final NewsDataSource _newsDataSource;

  const NewsRepository(this._newsDataSource);

  Future<List<News>> getNews({
    int from,
    int size,
    String queryField,
    String query,
  }) async {
    return _newsDataSource.getFeeds(from: from, size: size, queryField: queryField, query: query);
  }
}
