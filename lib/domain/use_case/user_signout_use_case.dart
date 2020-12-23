import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';
import 'package:spent/data/repository/authentication_repository.dart';
import 'package:spent/domain/model/news.dart';
import 'package:webview_flutter/webview_flutter.dart';

@injectable
class UserSignOutUseCase {
  final AuthenticationRepository _authenticationRepository;

  const UserSignOutUseCase(this._authenticationRepository);

  Future<void> call() async {
    try {
      await _authenticationRepository.signOut();
      await CookieManager().clearCookies();
      (await Hive.openBox<News>(News.boxName)).deleteFromDisk();
    } catch (err) {
      print(err);
    }
  }
}
