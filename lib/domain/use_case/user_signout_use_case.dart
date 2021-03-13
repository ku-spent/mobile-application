import 'package:injectable/injectable.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'package:spent/data/repository/authentication_repository.dart';
import 'package:spent/data/repository/news_repository.dart';

@injectable
class UserSignOutUseCase {
  final NewsRepository _newsRepository;
  final AuthenticationRepository _authenticationRepository;

  const UserSignOutUseCase(this._authenticationRepository, this._newsRepository);

  Future<void> call() async {
    try {
      await CookieManager().clearCookies();
      await _authenticationRepository.signOut();
      await _newsRepository.deleteNewsFromLocal();
    } catch (err) {
      print(err);
    }
  }
}
