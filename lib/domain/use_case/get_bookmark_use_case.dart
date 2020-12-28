import 'package:injectable/injectable.dart';
import 'package:spent/data/repository/authentication_repository.dart';
import 'package:spent/data/repository/news_repository.dart';
import 'package:spent/data/repository/user_repository.dart';
import 'package:spent/domain/model/ModelProvider.dart';
import 'package:spent/domain/model/News.dart';

@injectable
class GetBookmarkUseCase {
  final AuthenticationRepository _authenticationRepository;
  final UserRepository _userRepository;
  final NewsRepository _newsRepository;

  const GetBookmarkUseCase(this._authenticationRepository, this._userRepository, this._newsRepository);

  Future<List<News>> call() async {
    User user = await _authenticationRepository.getCurrentUser();
    List<Bookmark> bookmarks = await _userRepository.getBookmarksByUser(user);
    List<News> news = [];
    bookmarks.forEach((bookmark) async {
      News bookmarkNews = await _newsRepository.getNewsById(bookmark.news.id);
      if (bookmarkNews != null) news.add(bookmarkNews);
    });
    return news;
  }
}
