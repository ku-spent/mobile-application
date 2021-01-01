import 'package:injectable/injectable.dart';
import 'package:spent/data/repository/authentication_repository.dart';
import 'package:spent/data/repository/news_repository.dart';
import 'package:spent/data/repository/user_repository.dart';
import 'package:spent/domain/model/ModelProvider.dart';

@injectable
class GetNewsFeedUseCase {
  final NewsRepository _newsRepository;
  final UserRepository _userRepository;
  final AuthenticationRepository _authenticationRepository;

  const GetNewsFeedUseCase(this._newsRepository, this._userRepository, this._authenticationRepository);

  Future<List<News>> call({
    int from = 0,
    int size = 5,
    String queryField = '_',
    String query,
    bool isRemote = false,
  }) async {
    User user = await _authenticationRepository.getCurrentUser();
    List<News> newsList = isRemote
        ? await _newsRepository.getNewsFromRemote(from, size, queryField, query)
        : await _newsRepository.getNewsFromLocal(from, size, queryField, query);
    List<News> mappedUserNews =
        await Future.wait(newsList.map((news) => _userRepository.mapUserActionToNews(user, news)));
    return mappedUserNews;
  }
}
