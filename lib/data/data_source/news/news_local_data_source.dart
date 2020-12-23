import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';
import 'package:spent/data/data_source/news/news_data_source.dart';
import 'package:spent/domain/model/news.dart';

@injectable
class NewsLocalDataSource implements NewsDataSource {
  const NewsLocalDataSource();

  @override
  Future<List<News>> getFeeds(int from, int size, String queryField, String query) async {
    try {
      final newsBox = await Hive.openBox<News>(News.boxName);
      List<News> news = newsBox.values.where((news) => news.toMap()[queryField] == query).toList().reversed.toList();
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
      News news = newsBox.values.singleWhere((news) => news.id == id);
      // remote
      // TODO
      return news;
    } catch (e) {
      print('getNewsById: $e');
      return null;
    }
  }

  Future<void> cacheNews(List<News> newsList) async {
    final newsBox = await Hive.openBox<News>(News.boxName);
    newsList.reversed.forEach((news) async {
      final existNews = await getNewsById(news.id);
      print('existNews: $existNews');
      if (existNews == null) {
        final pubDate = news.pubDate;
        print('add news: $pubDate');
        newsBox.add(news);
      }
    });
  }
}
