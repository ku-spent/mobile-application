import 'package:injectable/injectable.dart';
import 'package:spent/domain/model/user.dart';

@injectable
class GetCurrentUserUseCase {
  Future<User> call() async {
    return Future.delayed(
      const Duration(milliseconds: 500),
      () => User(
        email: 'test@hotmail.com',
        name: 'test user',
        picture: 'testpic',
      ),
    );
  }
}
