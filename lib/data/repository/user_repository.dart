import 'package:injectable/injectable.dart';
import 'package:spent/data/data_source/user_storage/user_storage.dart';
import 'package:spent/domain/model/History.dart';
import 'package:spent/domain/model/news.dart';
import 'package:spent/domain/model/user.dart';

@singleton
class UserRepository {
  final UserStorage _userStorage;

  UserRepository(this._userStorage);

  Future<void> saveNewsHistory(User user, News news) async {
    await _userStorage.saveNewsHistory(user, news);
  }

  Future<void> updateNewsHistory(History oldHistory, History newHistory) async {
    await _userStorage.updateNewsHistory(oldHistory, newHistory);
  }

  Future<History> getHistoryByNewsId(User user, News news) async {
    final history = await _userStorage.getHistoryByNewsId(user, news);
    return history;
  }

  Future<List<History>> getNewsHistory(User user) async {
    final histories = await _userStorage.getNewsHistory(user);
    return histories;
  }
}
