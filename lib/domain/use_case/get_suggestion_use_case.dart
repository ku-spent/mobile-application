import 'package:injectable/injectable.dart';
import 'package:spent/data/repository/authentication_repository.dart';
import 'package:spent/data/repository/news_repository.dart';
import 'package:spent/data/repository/user_repository.dart';
import 'package:spent/domain/model/ModelProvider.dart';

@injectable
class GetSuggestionNewsUseCase {
  final NewsRepository _newsRepository;
  final UserRepository _userRepository;
  final AuthenticationRepository _authenticationRepository;

  const GetSuggestionNewsUseCase(this._newsRepository, this._userRepository, this._authenticationRepository);

  Future<List<News>> call({
    int from = 0,
    int size = 5,
    News curNews,
    bool isRemote = false,
  }) async {
    final User user = await _authenticationRepository.getCurrentUser();
    final List<News> newsList = isRemote
        ? await _newsRepository.getSuggestionNewsFromRemote(from, size, curNews)
        : await _newsRepository.getSuggestionNewsFromLocal(from, size, curNews);
    final List<News> mappedUserNews =
        await Future.wait(newsList.map((news) => _userRepository.mapUserActionToNews(user, news)));
    return mappedUserNews;
  }
}
