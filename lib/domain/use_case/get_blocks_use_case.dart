import 'package:injectable/injectable.dart';

import 'package:spent/helper/pagination.dart';
import 'package:spent/domain/model/ModelProvider.dart';
import 'package:spent/data/repository/user_repository.dart';
import 'package:spent/data/repository/authentication_repository.dart';

@injectable
class GetBlocksUseCase {
  final AuthenticationRepository _authenticationRepository;
  final UserRepository _userRepository;

  const GetBlocksUseCase(this._authenticationRepository, this._userRepository);

  Future<List<Block>> call({String query, int from, int size}) async {
    final User user = await _authenticationRepository.getCurrentUser();
    final PaginationOption paginationOption = PaginationOption(from, size);
    final List<Block> blocks =
        await _userRepository.getBlocksByUser(user, query: query.toLowerCase(), paginationOption: paginationOption);
    return blocks;
  }
}
