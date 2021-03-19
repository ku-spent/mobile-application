import 'package:injectable/injectable.dart';
import 'package:spent/data/repository/authentication_repository.dart';
import 'package:spent/data/repository/user_repository.dart';
import 'package:spent/domain/model/Following.dart';
import 'package:spent/domain/model/ModelProvider.dart';

@injectable
class DeleteFollowingUseCase {
  final AuthenticationRepository _authenticationRepository;
  final UserRepository _userRepository;

  const DeleteFollowingUseCase(this._userRepository, this._authenticationRepository);

  Future<void> call(Following following) async {
    final User user = await _authenticationRepository.getCurrentUser();
    await _userRepository.deleteFollowing(user, following);
  }
}
