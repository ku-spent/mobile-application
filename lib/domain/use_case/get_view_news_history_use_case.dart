import 'package:injectable/injectable.dart';
import 'package:spent/data/repository/authentication_repository.dart';
import 'package:spent/data/repository/user_repository.dart';
import 'package:spent/domain/model/History.dart';
import 'package:spent/domain/model/User.dart';

@injectable
class GetViewNewsHistoryUseCase {
  final AuthenticationRepository _authenticationRepository;
  final UserRepository _userRepository;

  const GetViewNewsHistoryUseCase(this._authenticationRepository, this._userRepository);

  Future<List<History>> call() async {
    User user = await _authenticationRepository.getCurrentUser();
    final histories = await _userRepository.getNewsHistory(user);
    histories.forEach((element) {
      print(element.createdAt);
    });
    return histories;
  }
}
