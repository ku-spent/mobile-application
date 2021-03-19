import 'package:amplify_api/amplify_api.dart';
import 'package:injectable/injectable.dart';
import 'package:spent/data/repository/authentication_repository.dart';
import 'package:spent/data/repository/user_repository.dart';
import 'package:spent/domain/model/Following.dart';
import 'package:spent/domain/model/ModelProvider.dart';

@injectable
class AddFollowingUseCase {
  final UserRepository _userRepository;
  final AuthenticationRepository _authenticationRepository;

  const AddFollowingUseCase(this._userRepository, this._authenticationRepository);

  Future<Following> call(String name, FollowingType type) async {
    final User user = await _authenticationRepository.getCurrentUser();
    final Following following = Following(id: UUID.getUUID(), name: name, type: type);
    return await _userRepository.addFollowing(user, following);
    ;
  }
}
