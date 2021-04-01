import 'package:injectable/injectable.dart';
import 'package:spent/data/repository/authentication_repository.dart';
import 'package:spent/data/repository/user_repository.dart';
import 'package:spent/domain/model/Following.dart';
import 'package:spent/domain/model/ModelProvider.dart';

@injectable
class GetFollowingListUseCase {
  final AuthenticationRepository _authenticationRepository;
  final UserRepository _userRepository;

  const GetFollowingListUseCase(this._userRepository, this._authenticationRepository);

  Future<List<Following>> call() async {
    final User user = await _authenticationRepository.getCurrentUser();
    final List<Following> followingList = await _userRepository.getFollowingList(user);
    return followingList;
  }
}
