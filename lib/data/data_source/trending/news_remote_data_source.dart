import 'package:amplify_api/amplify_api.dart';
import 'package:injectable/injectable.dart';
import 'package:spent/data/data_source/news/news_data_source.dart';
import 'package:spent/data/http_manager/amplify_http_manager.dart';
import 'package:spent/domain/model/News.dart';

@injectable
class TrendingRemoteDataSource {
  final AmplifyHttpManager _httpManager;

  const TrendingRemoteDataSource(this._httpManager);

  @override
  Future<List<News>> getTrending(int from, int size, News curNews) async {
    try {
      final RestOptions restOptions = RestOptions(
        path: "/trending",
        queryParameters: {
          'from': from.toString(),
          'size': size.toString(),
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
}
