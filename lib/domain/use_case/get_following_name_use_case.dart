import 'package:injectable/injectable.dart';
import 'package:spent/data/repository/authentication_repository.dart';
import 'package:spent/data/repository/user_repository.dart';
import 'package:spent/domain/model/Following.dart';
import 'package:spent/domain/model/ModelProvider.dart';

@injectable
class GetFollowingByNameUseCase {
  final AuthenticationRepository _authenticationRepository;
  final UserRepository _userRepository;

  const GetFollowingByNameUseCase(this._userRepository, this._authenticationRepository);

  Future<Following> call(String name, FollowingType followingType) async {
    final User user = await _authenticationRepository.getCurrentUser();
    final List<Following> followingList = await _userRepository.getFollowingList(user);

    final filtered = followingList.where((e) => e.name == name && e.type == followingType).toList();

    if (filtered.isEmpty) {
      return null;
    } else {
      print(filtered);
      return filtered[0];
    }
  }
}
