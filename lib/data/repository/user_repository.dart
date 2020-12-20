import 'package:injectable/injectable.dart';
import 'package:spent/data/data_source/user_storage/user_storage.dart';
import 'package:spent/domain/model/History.dart';
import 'package:spent/domain/model/news.dart';
import 'package:spent/domain/model/user.dart';

@singleton
class UserRepository {
  final UserStorage _userStorage;

  const UserRepository(this._userStorage);

  Future<History> saveNewsHistory(User user, News news) async {
    final history = await _userStorage.saveNewsHistory(user, news);
    return history;
  }
}
