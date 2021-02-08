import 'package:injectable/injectable.dart';
import 'package:spent/data/repository/authentication_repository.dart';
import 'package:spent/data/repository/explore.repository.dart';
import 'package:spent/data/repository/user_repository.dart';
import 'package:spent/domain/model/ModelProvider.dart';
import 'package:spent/domain/model/trending.dart';

@injectable
class GetExploreUseCase {
  final ExploreRepository _exploreRepository;
  final UserRepository _userRepository;
  final AuthenticationRepository _authenticationRepository;

  const GetExploreUseCase(this._exploreRepository, this._userRepository, this._authenticationRepository);

  Future<Trending> call({
    int from = 0,
    int size = 5,
  }) async {
    User user = await _authenticationRepository.getCurrentUser();
    final Trending trending = await _exploreRepository.getTrendingFromRemote(from, size);
    // List<TrendingTopic> trendingTopics = await Future.wait(trending.trendingTopics.map((trendingTopic) =>
    //     Future.wait(trendingTopic.newsList.map((news) => _userRepository.mapUserActionToNews(user, news)))));
    return trending;
  }
}
