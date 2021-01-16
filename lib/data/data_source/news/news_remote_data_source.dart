import 'package:injectable/injectable.dart';
import 'package:spent/data/data_source/news/news_data_source.dart';
import 'package:spent/data/http_manager/app_http_manager.dart';
import 'package:spent/domain/model/News.dart';

@injectable
class NewsRemoteDataSource implements NewsDataSource {
  final AppHttpManager _httpManager;

  const NewsRemoteDataSource(this._httpManager);

  @override
  Future<List<News>> getSuggestionNews(int from, int size, News curNews) async {
    try {
      final response = await _httpManager.get(
        path: '/news/related',
        query: Map.from({
          'from': from.toString(),
          'size': size.toString(),
          '_id': curNews.esId,
        }),
      );
      List items = response['data']['hits'];
      List<News> newsList = items.map((e) => News.fromJson(e['_source'], esId: e['_id'])).toList();
      // List<News> formattedNewsList = await Future.wait(newsList.map((e) => getNewsById(e.id)));
      return newsList;
    } catch (e) {
      print(e);
      throw e;
    }
  }

  @override
  Future<List<News>> getFeeds(int from, int size, String queryField, String query) async {
    try {
      final response = await _httpManager.get(
        path: '/news',
        query: Map.from({
          'from': from.toString(),
          'size': size.toString(),
          'queryField': queryField,
          'query': query,
        }),
      );
      List items = response['data']['hits'];
      List<News> newsList = items.map((e) => News.fromJson(e['_source'], esId: e['_id'])).toList();
      // List<News> formattedNewsList = await Future.wait(newsList.map((e) => getNewsById(e.id)));
      return newsList;
    } catch (e) {
      print(e);
      throw e;
    }
  }

  @override
  Future<News> getNewsById(String id) async {
    final response = await _httpManager.get(
      path: '/news',
      query: Map.from({
        'size': '1',
        'queryField': 'id',
        'query': id,
      }),
    );
    List items = response['data']['hits'];
    List<News> newsList = items.map((e) => News.fromJson(e['_source'], esId: e['_id'])).toList();
    News news = newsList.isNotEmpty ? newsList[0] : null;
    return news;
  }
}
