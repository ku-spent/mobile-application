import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';
import 'package:spent/data/data_source/news/news_remote_data_source.dart';
import 'package:spent/domain/model/news.dart';

@injectable
class NewsRepository {
  final NewsRemoteDataSource _newsRemoteDataSource;
  const NewsRepository(this._newsRemoteDataSource);

  Future<List<News>> getNewsFromRemote(
    int from,
    int size,
    String queryField,
    String query,
  ) async {
    return _newsRemoteDataSource.getFeeds(from, size, queryField, query);
  }

  Future<News> getNewsById(String id) async {
    final newsBox = await Hive.openBox<News>(News.boxName);
    final news = newsBox.get(id);
    return news;
  }

  Future<void> cacheNews(List<News> newsList) async {
    final newsBox = await Hive.openBox<News>(News.boxName);
    newsList.forEach((news) {
      newsBox.put(news.id, news);
    });
  }
}
