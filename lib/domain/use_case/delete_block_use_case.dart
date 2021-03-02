import 'package:injectable/injectable.dart';

import 'package:spent/data/repository/authentication_repository.dart';
import 'package:spent/data/repository/user_repository.dart';
import 'package:spent/domain/model/ModelProvider.dart';

@injectable
class DeleteBlockUseCase {
  final AuthenticationRepository _authenticationRepository;
  final UserRepository _userRepository;

  const DeleteBlockUseCase(this._authenticationRepository, this._userRepository);

  Future<void> call(Block block) async {
    await _userRepository.deleteBlock(block);
  }
}
