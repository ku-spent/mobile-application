import 'package:injectable/injectable.dart';
import 'package:spent/data/repository/authentication_repository.dart';
import 'package:spent/data/repository/news_repository.dart';
import 'package:spent/data/repository/user_repository.dart';
import 'package:spent/domain/model/ModelProvider.dart';
import 'package:spent/domain/model/Recommendation.dart';

@injectable
class GetRecommendationsUseCase {
  final NewsRepository _newsRepository;
  final UserRepository _userRepository;
  final AuthenticationRepository _authenticationRepository;

  const GetRecommendationsUseCase(this._newsRepository, this._userRepository, this._authenticationRepository);

  Future<Recommendation> call({
    int from = 0,
    int size = 5,
  }) async {
    try {
      final User user = await _authenticationRepository.getCurrentUser();
      final Recommendation recommendation = await _newsRepository.getRecommendations(user.id);
      // final List<News> mappedUserNews =
      //     await Future.wait(newsList.map((news) => _userRepository.mapUserActionToNews(user, news)));
      return recommendation;
    } catch (e) {
      print(e);
    }
  }
}
