import 'package:injectable/injectable.dart';
import 'package:spent/data/data_source/news/news_local_data_source.dart';
import 'package:spent/data/data_source/news/news_remote_data_source.dart';
import 'package:spent/domain/model/News.dart';
import 'package:spent/domain/model/Recommendation.dart';

@injectable
class NewsRepository {
  final NewsRemoteDataSource _newsRemoteDataSource;
  final NewsLocalDataSource _newsLocalDataSource;

  const NewsRepository(this._newsRemoteDataSource, this._newsLocalDataSource);

  Future<Recommendation> getRecommendations(String userId) async {
    final Recommendation recommendation = await _newsRemoteDataSource.getRecommendations(userId);
    await _newsLocalDataSource.cacheNews(recommendation.newsList);
    return recommendation;
  }

  Future<List<News>> getSuggestionNewsFromRemote(
    int from,
    int size,
    News curNews,
  ) async {
    final List<News> newsList = await _newsRemoteDataSource.getSuggestionNews(from, size, curNews);
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
    final List<News> newsList = await _newsRemoteDataSource.getFeeds(from, size, queryField, query);
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
      final News cachedNews = await _newsLocalDataSource.getNewsById(id);
      if (cachedNews == null) {
        final News news = await _newsRemoteDataSource.getNewsById(id);
        await _newsLocalDataSource.cacheNews([news]);
        return news;
      } else {
        return cachedNews;
      }
    } catch (e) {
      return null;
    }
  }
}
