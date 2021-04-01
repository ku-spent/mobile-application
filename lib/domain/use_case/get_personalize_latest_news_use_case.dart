import 'package:injectable/injectable.dart';
import 'package:spent/data/repository/authentication_repository.dart';
import 'package:spent/data/repository/news_repository.dart';
import 'package:spent/data/repository/user_repository.dart';
import 'package:spent/domain/model/ModelProvider.dart';

@injectable
class GetPersonalizeLatestNewsUseCase {
  final NewsRepository _newsRepository;
  final UserRepository _userRepository;
  final AuthenticationRepository _authenticationRepository;

  const GetPersonalizeLatestNewsUseCase(this._newsRepository, this._userRepository, this._authenticationRepository);

  Future<List<News>> call({
    int from = 0,
    int size = 5,
    bool isRemote = false,
  }) async {
    final User user = await _authenticationRepository.getCurrentUser();
    final List<News> newsList = isRemote
        ? await _newsRepository.getLatestNewsFromRemote(from, size, user)
        : await _newsRepository.getNewsFromLocal(from, size, null, null);
    final List<News> mappedUserNews =
        await Future.wait(newsList.map((news) => _userRepository.mapUserActionToNews(user, news)));
    return mappedUserNews;
  }
}
