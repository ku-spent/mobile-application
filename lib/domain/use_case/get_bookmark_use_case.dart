import 'package:injectable/injectable.dart';
import 'package:spent/data/repository/authentication_repository.dart';
import 'package:spent/data/repository/news_repository.dart';
import 'package:spent/data/repository/user_repository.dart';
import 'package:spent/domain/model/ModelProvider.dart';
import 'package:spent/domain/model/News.dart';
import 'package:spent/helper/pagination.dart';

@injectable
class GetBookmarkUseCase {
  final AuthenticationRepository _authenticationRepository;
  final UserRepository _userRepository;
  final NewsRepository _newsRepository;

  const GetBookmarkUseCase(this._authenticationRepository, this._userRepository, this._newsRepository);

  Future<List<News>> call({String query, int from = 0, int size = 10}) async {
    final User user = await _authenticationRepository.getCurrentUser();
    final PaginationOption paginationOption = PaginationOption(from, size);
    final List<Bookmark> bookmarks =
        await _userRepository.getBookmarksByUser(user, query: query.toLowerCase(), paginationOption: paginationOption);
    List<News> newsList = await Future.wait(bookmarks.map((bookmark) => _newsRepository.getNewsById(bookmark.newsId)));
    newsList = newsList.where((news) => news != null).toList();
    final List<News> mappedUserNews =
        await Future.wait(newsList.map((news) => _userRepository.mapUserActionToNews(user, news)));
    return mappedUserNews;
  }
}
