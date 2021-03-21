import 'package:injectable/injectable.dart';
import 'package:spent/data/repository/authentication_repository.dart';
import 'package:spent/domain/model/User.dart';

@injectable
class GetCurrentUserUseCase {
  final AuthenticationRepository _authenticationRepository;

  GetCurrentUserUseCase(this._authenticationRepository);

  Future<User> call() async {
    try {
      final isValidSession = await _authenticationRepository.isValidSession();
      if (!isValidSession) return null;
      print('get cur user');
      final user = await _authenticationRepository.getCurrentUser();
      print('get cur user ${user.name}');
      return user;
    } catch (err) {
      print(err);
    }
  }
}
