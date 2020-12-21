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
    print(user);
    List<History> histories = await _userRepository.getNewsHistory(user);
    // print(histories.first);
    histories.forEach((elem) {
      final id = elem.id;
      final u = elem.updatedAt.add(Duration(hours: 7));
      print('$id $u');
    });
    return histories;
  }
}
