import 'package:injectable/injectable.dart';
import 'package:spent/data/repository/authentication_repository.dart';
import 'package:spent/data/repository/user_repository.dart';
import 'package:spent/domain/model/History.dart';
import 'package:spent/domain/model/News.dart';
import 'package:spent/domain/model/User.dart';

@injectable
class DeleteUserViewNewsHistoryUseCase {
  final AuthenticationRepository _authenticationRepository;
  final UserRepository _userRepository;

  const DeleteUserViewNewsHistoryUseCase(this._authenticationRepository, this._userRepository);

  Future<void> call(News news) async {
    final User user = await _authenticationRepository.getCurrentUser();
    final History history = await _userRepository.getHistoryByNewsId(user, news);
    if (history != null) {
      await _userRepository.deleteNewsHistory(history);
    }
  }
}
