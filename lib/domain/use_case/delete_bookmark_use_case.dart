import 'package:injectable/injectable.dart';
import 'package:spent/data/repository/authentication_repository.dart';
import 'package:spent/data/repository/user_repository.dart';
import 'package:spent/domain/model/ModelProvider.dart';
import 'package:spent/domain/model/News.dart';
import 'package:spent/presentation/bloc/manage_bookmark/manage_bookmark_bloc.dart';

@injectable
class DeleteBookmarkUseCase {
  final AuthenticationRepository _authenticationRepository;
  final UserRepository _userRepository;

  const DeleteBookmarkUseCase(this._authenticationRepository, this._userRepository);

  Future<ManageBookmarkResult> call(News news) async {
    final User user = await _authenticationRepository.getCurrentUser();
    final Bookmark bookmark = await _userRepository.getBookmarkByNewsId(user, news);
    if (bookmark != null) {
      await _userRepository.deleteBookmark(bookmark);
    }
    news.isBookmarked = false;
    return ManageBookmarkResult(isBookmarked: false);
  }
}
