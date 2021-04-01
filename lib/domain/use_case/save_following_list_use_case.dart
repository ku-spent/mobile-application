import 'package:injectable/injectable.dart';
import 'package:spent/data/repository/authentication_repository.dart';
import 'package:spent/data/repository/user_repository.dart';
import 'package:spent/domain/model/Following.dart';
import 'package:spent/domain/model/ModelProvider.dart';

@injectable
class SaveFollowingListUseCase {
  final UserRepository _userRepository;
  final AuthenticationRepository _authenticationRepository;

  const SaveFollowingListUseCase(this._userRepository, this._authenticationRepository);

  Future<void> call(List<Following> followingList) async {
    final User user = await _authenticationRepository.getCurrentUser();
    await _userRepository.saveFollowingList(user, followingList);
  }
}
