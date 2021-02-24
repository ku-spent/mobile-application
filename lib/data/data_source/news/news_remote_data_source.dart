import 'package:amplify_api/amplify_api.dart';
import 'package:injectable/injectable.dart';
import 'package:spent/data/data_source/news/news_data_source.dart';
import 'package:spent/data/http_manager/amplify_http_manager.dart';
import 'package:spent/domain/model/News.dart';
import 'package:spent/domain/model/Recommendation.dart';

@injectable
class NewsRemoteDataSource implements NewsDataSource {
  final AmplifyHttpManager _httpManager;

  const NewsRemoteDataSource(this._httpManager);

  @override
  Future<Recommendation> getRecommendations(String userId) async {
    final RestOptions restOptions = RestOptions(
      path: "/recommendations",
      queryParameters: {
        'id': userId,
      },
    );
    final Map<String, dynamic> response = await _httpManager.get(restOptions);
    final List<String> newsIdList = List<String>.from(response['data']['itemList'].map((e) => e['ItemId']).toList());
    final recommendation = Recommendation(newsIdList: newsIdList, recommendationID: response['RecommendationId']);
    return recommendation;
  }

  @override
  Future<List<News>> getSuggestionNews(int from, int size, News curNews) async {
    try {
      final RestOptions restOptions = RestOptions(
        path: "/news/related",
        queryParameters: {
          'from': from.toString(),
          'size': size.toString(),
          '_id': curNews.esId,
        },
      );
      final Map<String, dynamic> response = await _httpManager.get(restOptions);
      final List items = response['data']['hits'];
      final List<News> newsList = items.map((e) => News.fromJson(e['_source'], esId: e['_id'])).toList();
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
      final List<News> newsList = items.map((e) => News.fromJson(e['_source'], esId: e['_id'])).toList();
      return newsList;
    } catch (error) {
      print(error.details);
      throw error;
    }
  }

  @override
  Future<News> getNewsById(String id) async {
    final RestOptions restOptions = RestOptions(
      path: "/news",
      queryParameters: {
        'size': '1',
        'queryField': 'id',
        'query': id,
      },
    );
    final Map<String, dynamic> response = await _httpManager.get(restOptions);
    final List items = response['data']['hits'];
    final List<News> newsList = items.map((e) => News.fromJson(e['_source'], esId: e['_id'])).toList();
    final News news = newsList.isNotEmpty ? newsList[0] : null;
    return news;
  }
}
