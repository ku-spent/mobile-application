import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:spent/data/repository/authentication_repository.dart';
import 'package:spent/data/repository/user_repository.dart';
import 'package:spent/domain/model/ModelProvider.dart';
import 'package:spent/domain/model/News.dart';

@injectable
class SaveBookmarkUseCase {
  final AuthenticationRepository _authenticationRepository;
  final UserRepository _userRepository;

  const SaveBookmarkUseCase(this._authenticationRepository, this._userRepository);

  Future<SaveBookmarkResult> call(News news) async {
    User user = await _authenticationRepository.getCurrentUser();
    Bookmark bookmark = await _userRepository.getBookmarkByNewsId(user, news);
    if (bookmark != null) {
      news.isBookmarked = false;
      await _userRepository.deleteBookmark(bookmark);
      return SaveBookmarkResult(isBookmarked: false);
    } else {
      news.isBookmarked = true;
      await _userRepository.saveBookmark(user, news);
      return SaveBookmarkResult(isBookmarked: true);
    }
  }
}

class SaveBookmarkResult extends Equatable {
  final bool isBookmarked;

  const SaveBookmarkResult({this.isBookmarked});

  @override
  List<Object> get props => [isBookmarked];
}
