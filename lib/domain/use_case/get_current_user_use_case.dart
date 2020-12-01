import 'package:injectable/injectable.dart';
import 'package:spent/data/repository/authentication_repository.dart';
import 'package:spent/domain/model/user.dart';

@injectable
class GetCurrentUserUseCase {
  final AuthenticationRepository _authenticationRepository;

  const GetCurrentUserUseCase(this._authenticationRepository);

  Future<User> call() async {
    try {
      final token = await _authenticationRepository.getToken();
      final user = await _authenticationRepository.getUserFromSession(token);
      return user;
    } catch (err) {
      print(err);
    }
  }
}
