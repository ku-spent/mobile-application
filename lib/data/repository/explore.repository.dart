import 'package:injectable/injectable.dart';
import 'package:spent/data/data_source/trending/trending_remote_data_source.dart';
import 'package:spent/domain/model/trending.dart';

@injectable
class ExploreRepository {
  final TrendingRemoteDataSource _trendingRemoteDataSource;

  const ExploreRepository(this._trendingRemoteDataSource);

  Future<Trending> getTrendingFromRemote(
    int from,
    int size,
  ) async {
    final Trending trending = await _trendingRemoteDataSource.getTrending(from, size);
    return trending;
  }
}
