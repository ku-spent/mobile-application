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

  Future<void> call(News news) async {
    User user = await _authenticationRepository.getCurrentUser();
    Bookmark bookmark = await _userRepository.getBookmarkNewsId(user, news);
    if (bookmark != null) {
      await _userRepository.deleteBookmark(bookmark);
    } else {
      await _userRepository.saveBookmark(user, news);
    }
  }
}