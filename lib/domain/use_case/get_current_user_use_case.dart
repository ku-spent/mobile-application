import 'package:injectable/injectable.dart';
import 'package:spent/data/repository/authentication_repository.dart';
import 'package:spent/domain/model/user.dart';

@injectable
class GetCurrentUserUseCase {
  final AuthenticationRepository _authenticationRepository;

  const GetCurrentUserUseCase(this._authenticationRepository);

  Future<User> call() async {
    try {
      final user = await _authenticationRepository.getUserFromSession();
      return user;
    } catch (err) {
      print(err);
    }
  }
}
