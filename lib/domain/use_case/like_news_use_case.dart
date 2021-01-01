import 'package:injectable/injectable.dart';
import 'package:spent/data/repository/authentication_repository.dart';
import 'package:spent/data/repository/user_repository.dart';
import 'package:spent/domain/model/ModelProvider.dart';
import 'package:spent/domain/model/News.dart';
import 'package:spent/domain/model/User.dart';

@injectable
class LikeNewsUseCase {
  final AuthenticationRepository _authenticationRepository;
  final UserRepository _userRepository;

  const LikeNewsUseCase(this._authenticationRepository, this._userRepository);

  Future<void> call(News news) async {
    User user = await _authenticationRepository.getCurrentUser();
    UserNewsAction userNewsAction = await _userRepository.getUserNewsActionByNewsId(user, news);
    if (userNewsAction != null) {
      await _userRepository.deleteUserNewsAction(userNewsAction);
    } else {
      await _userRepository.saveUserNewsAction(user, news);
    }
  }
}
