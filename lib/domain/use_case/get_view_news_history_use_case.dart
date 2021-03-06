import 'package:injectable/injectable.dart';
import 'package:spent/data/repository/authentication_repository.dart';
import 'package:spent/data/repository/news_repository.dart';
import 'package:spent/data/repository/user_repository.dart';
import 'package:spent/domain/model/History.dart';
import 'package:spent/domain/model/User.dart';
import 'package:spent/domain/model/News.dart';
import 'package:spent/helper/pagination.dart';

@injectable
class GetViewNewsHistoryUseCase {
  final AuthenticationRepository _authenticationRepository;
  final UserRepository _userRepository;
  final NewsRepository _newsRepository;

  const GetViewNewsHistoryUseCase(this._authenticationRepository, this._userRepository, this._newsRepository);

  Future<List<News>> call({String query, int from, int size}) async {
    final User user = await _authenticationRepository.getCurrentUser();
    final PaginationOption paginationOption = PaginationOption(from, size);
    final List<History> histories = await _userRepository.getNewsHistoryByUser(user,
        query: query.toLowerCase(), paginationOption: paginationOption);
    List<News> newsList = await Future.wait(histories.map((history) => _newsRepository.getNewsById(history.newsId)));
    newsList = newsList.where((news) => news != null).toList();
    final List<News> mappedUserNews =
        await Future.wait(newsList.map((news) => _userRepository.mapUserActionToNews(user, news)));
    return mappedUserNews;
  }
}
