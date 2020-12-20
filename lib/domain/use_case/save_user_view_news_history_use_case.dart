import 'package:injectable/injectable.dart';
import 'package:spent/data/repository/authentication_repository.dart';
import 'package:spent/data/repository/user_repository.dart';
import 'package:spent/domain/model/History.dart';
import 'package:spent/domain/model/news.dart';
import 'package:spent/domain/model/User.dart';

@injectable
class SaveUserViewNewsHistoryUseCase {
  final AuthenticationRepository _authenticationRepository;
  final UserRepository _userRepository;

  const SaveUserViewNewsHistoryUseCase(this._authenticationRepository, this._userRepository);

  Future<void> call(News news) async {
    User user = await _authenticationRepository.getCurrentUser();
    History oldHistory = await _userRepository.getHistoryByNewsId(user, news);
    if (oldHistory != null) {
      final newHistory = History();
      await _userRepository.updateNewsHistory(oldHistory, newHistory);
    } else {
      await _userRepository.saveNewsHistory(user, news);
    }
  }
}
