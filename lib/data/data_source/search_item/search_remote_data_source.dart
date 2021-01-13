import 'package:injectable/injectable.dart';
import 'package:spent/data/http_manager/app_http_manager.dart';
import 'package:spent/domain/model/ModelProvider.dart';

@injectable
class SearchRemoteDataSource {
  final AppHttpManager _httpManager;

  const SearchRemoteDataSource(this._httpManager);

  Future<List<News>> getSearchItems(String query) async {
    try {
      final response = await _httpManager.get(
        path: '/search',
        query: Map.from({
          'q': query,
        }),
      );
      List items = response['data']['hits'];
      List<News> newsList = items.map((e) => News.fromJson(e['_source'])).toList();
      return newsList;
    } catch (e) {
      print(e);
      throw e;
    }
  }
}
