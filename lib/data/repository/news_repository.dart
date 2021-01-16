import 'package:injectable/injectable.dart';
import 'package:spent/data/data_source/news/news_local_data_source.dart';
import 'package:spent/data/data_source/news/news_remote_data_source.dart';
import 'package:spent/domain/model/News.dart';

@injectable
class NewsRepository {
  final NewsRemoteDataSource _newsRemoteDataSource;
  final NewsLocalDataSource _newsLocalDataSource;

  const NewsRepository(this._newsRemoteDataSource, this._newsLocalDataSource);

  Future<List<News>> getSuggestionNewsFromRemote(
    int from,
    int size,
    News curNews,
  ) async {
    List<News> newsList = await _newsRemoteDataSource.getSuggestionNews(from, size, curNews);
    await _newsLocalDataSource.cacheNews(newsList);
    return newsList;
  }

  Future<List<News>> getSuggestionNewsFromLocal(
    int from,
    int size,
    News curNews,
  ) async {
    final newsList = await _newsLocalDataSource.getSuggestionNews(from, size, curNews);
    return newsList;
  }

  Future<List<News>> getNewsFromRemote(
    int from,
    int size,
    String queryField,
    String query,
  ) async {
    List<News> newsList = await _newsRemoteDataSource.getFeeds(from, size, queryField, query);
    await _newsLocalDataSource.cacheNews(newsList);
    return newsList;
  }

  Future<List<News>> getNewsFromLocal(
    int from,
    int size,
    String queryField,
    String query,
  ) async {
    final newsList = await _newsLocalDataSource.getFeeds(from, size, queryField, query);
    return newsList;
  }

  Future<News> getNewsById(String id) async {
    try {
      News cachedNews = await _newsLocalDataSource.getNewsById(id);
      if (cachedNews == null) {
        return await _newsRemoteDataSource.getNewsById(id);
      } else {
        return cachedNews;
      }
    } catch (e) {
      return null;
    }
  }
}
