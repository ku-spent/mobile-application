import 'package:amplify_core/amplify_core.dart';
import 'package:amplify_datastore_plugin_interface/amplify_datastore_plugin_interface.dart';
import 'package:injectable/injectable.dart';
import 'package:spent/domain/model/History.dart';
import 'package:spent/domain/model/ModelProvider.dart';
// import 'package:spent/domain/model/News.dart';
import 'package:spent/domain/model/User.dart';

@singleton
class UserStorage {
  const UserStorage();

  Future<void> saveNewsHistory(User user, News news) async {
    final history = History(
      news: news,
      user: user,
      status: HistoryStatus.ACTIVE,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
    await Amplify.DataStore.save(history);
  }

  Future<void> updateNewsHistory(History oldHistory, History newHistory) async {
    final history = oldHistory.copyWith(
      status: newHistory.status ?? oldHistory.status,
      updatedAt: DateTime.now(),
    );
    await Amplify.DataStore.save(history);
  }

  Future<History> getHistoryByNewsId(User user, News news) async {
    try {
      History history = (await Amplify.DataStore.query(
        History.classType,
        where: QueryPredicateOperation('user.id', EqualQueryOperator(user.id))
            .and(QueryPredicateOperation('news.id', EqualQueryOperator(news.id))),
      ))[0];
      return history;
    } catch (err) {
      print(err);
    }
  }

  Future<List<History>> getNewsHistoryByUser(User user) async {
    final histories = await Amplify.DataStore.query(
      History.classType,
      where: QueryPredicateOperation('user.id', EqualQueryOperator(user.id)).and(History.STATUS.eq('ACTIVE')),
      sortBy: [History.UPDATEDAT.descending()],
    );
    // sort desc
    histories.sort((a, b) => b.updatedAt.compareTo(a.updatedAt));

    return histories;
  }

  Future<void> saveBookmark(User user, News news) async {
    final bookmark = Bookmark(
      news: news,
      user: user,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
    await Amplify.DataStore.save(bookmark);
  }

  Future<void> deleteBookmark(Bookmark bookmark) async {
    await Amplify.DataStore.delete(bookmark);
  }

  Future<Bookmark> getBookmarkByNewsId(User user, News news) async {
    try {
      Bookmark bookmark = (await Amplify.DataStore.query(
        Bookmark.classType,
        where: QueryPredicateOperation('user.id', EqualQueryOperator(user.id))
            .and(QueryPredicateOperation('news.id', EqualQueryOperator(news.id))),
      ))[0];
      return bookmark;
    } catch (e) {
      print(e);
    }
  }

  Future<List<Bookmark>> getBookmarksByUser(User user) async {
    final bookmarks = await Amplify.DataStore.query(
      Bookmark.classType,
      where: QueryPredicateOperation('user.id', EqualQueryOperator(user.id)),
      sortBy: [Bookmark.UPDATEDAT.descending()],
    );
    // sort desc
    bookmarks.sort((a, b) => b.updatedAt.compareTo(a.updatedAt));
    return bookmarks;
  }
}
