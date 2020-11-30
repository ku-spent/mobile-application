import 'package:injectable/injectable.dart';

@injectable
class UserLogoutUseCase {
  Future call() async => Future.delayed(
        const Duration(milliseconds: 500),
        () {},
      );
}
