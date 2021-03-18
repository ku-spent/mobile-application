import 'package:amplify_api/amplify_api.dart';
import 'package:injectable/injectable.dart';
import 'package:spent/data/http_manager/amplify_http_manager.dart';
import 'package:spent/domain/model/ModelProvider.dart';
import 'package:spent/domain/model/Recommendation.dart';

@injectable
class PersonalizeRemoteDataSource {
  final AmplifyHttpManager _httpManager;

  const PersonalizeRemoteDataSource(this._httpManager);

  @override
  Future<Recommendation> getRecommendations(String userId) async {
    final RestOptions restOptions = RestOptions(
      path: "/personalize/recommendations",
      queryParameters: {
        'id': userId,
      },
    );
    final Map<String, dynamic> response = await _httpManager.get(restOptions);
    final List<String> newsIdList = List<String>.from(response['data']['itemList'].map((e) => e['ItemId']).toList());
    final recommendation =
        Recommendation(newsIdList: newsIdList, recommendationID: response['data']['RecommendationId']);
    return recommendation;
  }

  @override
  Future<List<News>> getLatestFeeds(int from, int size, String userId) async {
    try {
      final RestOptions restOptions = RestOptions(
        path: "/personalize/latest",
        queryParameters: {
          'from': from.toString(),
          'size': size.toString(),
          'id': userId,
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
}
