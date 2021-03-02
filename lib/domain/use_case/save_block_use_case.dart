import 'package:injectable/injectable.dart';

import 'package:spent/data/repository/authentication_repository.dart';
import 'package:spent/data/repository/user_repository.dart';
import 'package:spent/domain/model/ModelProvider.dart';

@injectable
class SaveBlockUseCase {
  final AuthenticationRepository _authenticationRepository;
  final UserRepository _userRepository;

  const SaveBlockUseCase(this._authenticationRepository, this._userRepository);

  Future<void> call(String name, BlockTypes type) async {
    final User user = await _authenticationRepository.getCurrentUser();
    await _userRepository.saveBlock(user, name, type);
  }
}
