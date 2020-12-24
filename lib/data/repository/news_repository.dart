import 'package:injectable/injectable.dart';
import 'package:spent/data/data_source/news/news_local_data_source.dart';
import 'package:spent/data/data_source/news/news_remote_data_source.dart';
import 'package:spent/domain/model/News.dart';

@injectable
class NewsRepository {
  final NewsRemoteDataSource _newsRemoteDataSource;
  final NewsLocalDataSource _newsLocalDataSource;

  const NewsRepository(this._newsRemoteDataSource, this._newsLocalDataSource);

  Future<List<News>> getNewsFromRemote(
    int from,
    int size,
    String queryField,
    String query,
  ) async {
    final news = await _newsRemoteDataSource.getFeeds(from, size, queryField, query);
    await _newsLocalDataSource.cacheNews(news);
    return news;
  }

  Future<List<News>> getNewsFromLocal(
    int from,
    int size,
    String queryField,
    String query,
  ) async {
    final news = await _newsLocalDataSource.getFeeds(from, size, queryField, query);
    return news;
  }

  Future<News> getNewsById(String id) async {
    try {
      final news = _newsLocalDataSource.getNewsById(id);
      return news;
    } catch (e) {
      return null;
    }
  }
}
