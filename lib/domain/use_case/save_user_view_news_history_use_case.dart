import 'package:amplify_analytics_pinpoint/amplify_analytics_pinpoint.dart';
import 'package:amplify_core/amplify_core.dart';
import 'package:injectable/injectable.dart';
import 'package:spent/data/repository/authentication_repository.dart';
import 'package:spent/data/repository/user_repository.dart';
import 'package:spent/domain/model/news.dart';
import 'package:spent/domain/model/user.dart';

@injectable
class SaveUserViewNewsHistoryUseCase {
  final AuthenticationRepository _authenticationRepository;
  final UserRepository _userRepository;

  const SaveUserViewNewsHistoryUseCase(this._authenticationRepository, this._userRepository);

  Future<void> call(News news) async {
    User user = await _authenticationRepository.getCurrentUser();
    await _userRepository.saveNewsHistory(user, news);
  }
}
