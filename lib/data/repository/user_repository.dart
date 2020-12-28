import 'package:injectable/injectable.dart';
import 'package:spent/data/data_source/user_storage/user_storage.dart';
import 'package:spent/domain/model/History.dart';
import 'package:spent/domain/model/ModelProvider.dart';
import 'package:spent/domain/model/News.dart';
import 'package:spent/domain/model/User.dart';

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

  Future<List<History>> getNewsHistoryByUser(User user) async {
    final histories = await _userStorage.getNewsHistoryByUser(user);
    return histories;
  }

  Future<void> saveBookmark(User user, News news) async {
    await _userStorage.saveBookmark(user, news);
  }

  Future<void> deleteBookmark(Bookmark bookmark) async {
    await _userStorage.deleteBookmark(bookmark);
  }

  Future<Bookmark> getBookmarkNewsId(User user, News news) async {
    final bookmark = await _userStorage.getBookmarkByNewsId(user, news);
    return bookmark;
  }

  Future<List<Bookmark>> getBookmarksByUser(User user) async {
    final bookmarks = await _userStorage.getBookmarksByUser(user);
    return bookmarks;
  }
}
