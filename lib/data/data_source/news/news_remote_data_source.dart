import 'package:injectable/injectable.dart';
import 'package:spent/data/data_source/news/news_data_source.dart';
import 'package:spent/data/http_manager/app_http_manager.dart';
import 'package:spent/domain/model/news.dart';

@injectable
class NewsRemoteDataSource implements NewsDataSource {
  final AppHttpManager _httpManager;

  const NewsRemoteDataSource(this._httpManager);

  @override
  Future<List<News>> getFeeds(int from, int size, String queryField, String query) async {
    try {
      final response = await _httpManager.get(
        path: '/feed',
        query: Map.from({
          'from': from.toString(),
          'size': size.toString(),
          'queryField': queryField,
          'query': query,
        }),
      );
      List items = response['data']['hits'];
      return items.map((e) => News.fromJson(e['_source'])).toList();
    } catch (e) {
      print(e);
      throw e;
    }
  }

  @override
  Future<News> getNewsById(String id) {
    // TODO: implement getNewsById
    throw UnimplementedError();
  }
}
