import 'package:amplify_api/amplify_api.dart';
import 'package:injectable/injectable.dart';
import 'package:spent/data/data_source/news/news_data_source.dart';
import 'package:spent/data/http_manager/amplify_http_manager.dart';
import 'package:spent/domain/model/News.dart';

@injectable
class NewsRemoteDataSource implements NewsDataSource {
  final AmplifyHttpManager _httpManager;

  const NewsRemoteDataSource(this._httpManager);

  @override
  Future<List<News>> getSuggestionNews(int from, int size, News curNews) async {
    try {
      final RestOptions restOptions = RestOptions(
        path: "/news/related",
        queryParameters: {
          'from': from.toString(),
          'size': size.toString(),
          'id': curNews.id,
        },
      );
      final Map<String, dynamic> response = await _httpManager.get(restOptions);
      final List items = response['data']['hits'];
      final List<News> newsList = items.map((e) => News.fromJson(e['_source'])).toList();
      return newsList;
    } catch (e) {
      print(e);
      throw e;
    }
  }

  @override
  Future<List<News>> getFeeds(int from, int size, String queryField, String query) async {
    try {
      final RestOptions restOptions = RestOptions(
        path: "/news",
        queryParameters: {
          'from': from.toString(),
          'size': size.toString(),
          'queryField': queryField,
          'query': query ?? '',
        },
      );
      final Map<String, dynamic> response = await _httpManager.get(restOptions);
      final List items = response['data']['hits'];
      final List<News> newsList = items.map((e) => News.fromJson(e['_source'])).toList();
      return newsList;
    } catch (error) {
      print(error.details);
      throw error;
    }
  }

  @override
  Future<News> getNewsById(String id) async {
    final RestOptions restOptions = RestOptions(
      path: "/news2/$id",
    );
    final Map<String, dynamic> response = await _httpManager.get(restOptions);
    final item = response['data'];
    if (item == null) return null;

    final news = News.fromJson(item);
    return news;
  }

  @override
  Future<List<News>> getNewsRelatedTrend(String trend, int from, int size) async {
    try {
      final RestOptions restOptions = RestOptions(
        path: "/trending/related",
        queryParameters: {
          'from': from.toString(),
          'size': size.toString(),
          'trend': trend,
        },
      );
      final Map<String, dynamic> response = await _httpManager.get(restOptions);
      final List items = response['data']['news'];
      final List<News> newsList = items.map((e) => News.fromJson(e['_source'])).toList();
      return newsList;
    } catch (e) {
      print(e);
      throw e;
    }
  }
}
