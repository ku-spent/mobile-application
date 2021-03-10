import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';
import 'package:spent/data/data_source/news/news_data_source.dart';
import 'package:spent/domain/model/News.dart';
import 'package:spent/domain/model/Recommendation.dart';

@injectable
class NewsLocalDataSource implements NewsDataSource {
  const NewsLocalDataSource();

  @override
  Future<List<News>> getNewsRelatedTrend(String trend, int from, int size) {
    // TODO: implement getNewsRelatedTrend
    throw null;
  }

  @override
  Future<Recommendation> getRecommendations(String userId) async {
    // TODO: implement local recommendations
    return null;
  }

  @override
  Future<List<News>> getSuggestionNews(int from, int size, News curNews) async {
    try {
      final newsBox = await Hive.openBox<News>(News.boxName);
      final List<News> news =
          newsBox.values.where((news) => news.toJson()['category'] == curNews.category).toList().reversed.toList();
      return news;
    } catch (e) {
      print(e);
      throw e;
    }
  }

  @override
  Future<List<News>> getFeeds(int from, int size, String queryField, String query) async {
    try {
      final newsBox = await Hive.openBox<News>(News.boxName);
      final List<News> news =
          newsBox.values.where((news) => news.toJson()[queryField] == query).toList().reversed.toList();
      return news;
    } catch (e) {
      print(e);
      throw e;
    }
  }

  @override
  Future<News> getNewsById(String id) async {
    try {
      final newsBox = await Hive.openBox<News>(News.boxName);
      final News news = newsBox.values.singleWhere((news) => news.id == id);
      return news;
    } catch (e) {
      return null;
    }
  }

  Future<void> cacheNews(List<News> newsList) async {
    final newsBox = await Hive.openBox<News>(News.boxName);
    newsList.reversed.forEach((news) async {
      if (news != null) {
        final existNews = await getNewsById(news.id);
        if (existNews == null) {
          newsBox.add(news);
        }
      }
    });
  }
}
