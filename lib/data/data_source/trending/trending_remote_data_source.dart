import 'package:amplify_api/amplify_api.dart';
import 'package:injectable/injectable.dart';
import 'package:spent/data/http_manager/amplify_http_manager.dart';
import 'package:spent/domain/model/trending.dart';

@injectable
class TrendingRemoteDataSource {
  final AmplifyHttpManager _httpManager;

  const TrendingRemoteDataSource(this._httpManager);

  @override
  Future<Trending> getTrending(int from, int size) async {
    try {
      final RestOptions restOptions = RestOptions(
        path: "/trending",
        queryParameters: {
          'from': from.toString(),
          'size': size.toString(),
        },
      );
      final Map<String, dynamic> response = await _httpManager.get(restOptions);
      final Trending trending = Trending.fromJson(response['data']);
      return trending;
    } catch (e) {
      print(e);
      throw e;
    }
  }
}
