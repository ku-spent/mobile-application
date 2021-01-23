import 'package:amplify_api/amplify_api.dart';
import 'package:injectable/injectable.dart';
import 'package:spent/data/http_manager/amplify_http_manager.dart';
import 'package:spent/domain/model/ModelProvider.dart';

@injectable
class SearchRemoteDataSource {
  final AmplifyHttpManager _httpManager;

  const SearchRemoteDataSource(this._httpManager);

  Future<List<News>> getSearchItems(String query) async {
    try {
      final RestOptions restOptions = RestOptions(
        path: "/search",
        queryParameters: {
          'q': query,
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
}
