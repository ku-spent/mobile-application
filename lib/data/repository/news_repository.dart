import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';

import 'package:spent/domain/model/ModelProvider.dart';
import 'package:spent/domain/model/Recommendation.dart';
import 'package:spent/data/data_source/news/news_local_data_source.dart';
import 'package:spent/data/data_source/news/news_remote_data_source.dart';
import 'package:spent/data/data_source/personalize/personalize_remote_data_source.dart';

@injectable
class NewsRepository {
  final NewsRemoteDataSource _newsRemoteDataSource;
  final NewsLocalDataSource _newsLocalDataSource;
  final PersonalizeRemoteDataSource _personalizeRemoteDataSource;

  const NewsRepository(this._newsRemoteDataSource, this._newsLocalDataSource, this._personalizeRemoteDataSource);

  Future<List<News>> getNewsRelatedTrend(String trend, int from, int size) async {
    final List<News> newsList = await _newsRemoteDataSource.getNewsRelatedTrend(trend, from, size);
    await _newsLocalDataSource.cacheNews(newsList);
    return newsList;
  }

  Future<Recommendation> getRecommendations(String userId) async {
    final Recommendation recommendation = await _personalizeRemoteDataSource.getRecommendations(userId);
    List<News> newsList = await Future.wait(recommendation.newsIdList.map((id) => getNewsById(id)));
    newsList = newsList.where((e) => e != null).toList();
    recommendation.setNewsList(newsList);
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

  Future<List<News>> getLatestNewsFromRemote(
    int from,
    int size,
    User user,
  ) async {
    final List<News> newsList = await _personalizeRemoteDataSource.getLatestFeeds(from, size, user.id);
    await _newsLocalDataSource.cacheNews(newsList);
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

  Future<void> deleteNewsFromLocal() async {
    final newsBox = await Hive.openBox<News>(News.boxName);
    await newsBox.deleteFromDisk();
  }
}
