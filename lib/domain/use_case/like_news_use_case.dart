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

  Future<LikeNewsResult> call(News news) async {
    final User user = await _authenticationRepository.getCurrentUser();
    final UserNewsAction userNewsAction = await _userRepository.getUserNewsActionByNewsId(user, news);
    if (userNewsAction != null) {
      await _userRepository.deleteUserNewsAction(userNewsAction);
      news.userAction = UserAction.NONE;
      return LikeNewsResult(userAction: UserAction.NONE);
    } else {
      await _userRepository.saveUserNewsAction(user, news);
      news.userAction = UserAction.LIKE;
      return LikeNewsResult(userAction: UserAction.LIKE);
    }
  }
}

class LikeNewsResult {
  final UserAction userAction;

  const LikeNewsResult({this.userAction});

  // @override
  // List<Object> get props => [userAction];
}
