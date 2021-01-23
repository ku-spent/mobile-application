import 'package:amplify_datastore_plugin_interface/amplify_datastore_plugin_interface.dart';
import 'package:amplify_flutter/amplify.dart';
import 'package:injectable/injectable.dart';
import 'package:spent/domain/model/History.dart';
import 'package:spent/domain/model/ModelProvider.dart';

@singleton
class UserStorage {
  const UserStorage();

  // History
  Future<void> saveNewsHistory(User user, News news) async {
    final history = History(
      id: UUID.getUUID(),
      newsId: news.id,
      userId: user.id,
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
      List<History> histories = await Amplify.DataStore.query(
        History.classType,
        where: History.USERID.eq(user.id).and(History.STATUS.eq('ACTIVE')).and(History.NEWSID.eq(news.id)),
      );
      History history = histories.isNotEmpty ? histories[0] : null;
      return history;
    } catch (err) {
      print(err);
    }
  }

  Future<List<History>> getNewsHistoryByUser(User user) async {
    final histories = await Amplify.DataStore.query(
      History.classType,
      where: History.USERID.eq(user.id).and(History.STATUS.eq('ACTIVE')),
      sortBy: [History.UPDATEDAT.descending()],
    );
    // sort desc
    histories.sort((a, b) => b.updatedAt.compareTo(a.updatedAt));

    return histories;
  }

  // Bookmark
  Future<void> saveBookmark(User user, News news) async {
    final bookmark = Bookmark(
      id: UUID.getUUID(),
      newsId: news.id,
      userId: user.id,
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
      List<Bookmark> bookmarks = await Amplify.DataStore.query(
        Bookmark.classType,
        where: Bookmark.USERID.eq(user.id).and(Bookmark.NEWSID.eq(news.id)),
      );
      Bookmark bookmark = bookmarks.isNotEmpty ? bookmarks[0] : null;
      return bookmark;
    } catch (e) {
      print(e);
    }
  }

  Future<List<Bookmark>> getBookmarksByUser(User user) async {
    final bookmarks = await Amplify.DataStore.query(
      Bookmark.classType,
      where: Bookmark.USERID.eq(user.id),
      sortBy: [Bookmark.UPDATEDAT.descending()],
    );
    // sort desc
    bookmarks.sort((a, b) => b.updatedAt.compareTo(a.updatedAt));
    return bookmarks;
  }

  // UserNewsAction
  Future<void> saveUserNewsAction(User user, News news) async {
    final userNewsAction = UserNewsAction(
      id: UUID.getUUID(),
      newsId: news.id,
      userId: user.id,
      action: UserAction.LIKE,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
    await Amplify.DataStore.save(userNewsAction);
  }

  Future<void> deleteUserNewsAction(UserNewsAction userNewsAction) async {
    await Amplify.DataStore.delete(userNewsAction);
  }

  Future<UserNewsAction> getUserNewsActionByNewsId(User user, News news) async {
    try {
      List<UserNewsAction> userNewsActions = await Amplify.DataStore.query(UserNewsAction.classType,
          where: UserNewsAction.USERID
              .eq(user.id)
              .and(UserNewsAction.NEWSID.eq(news.id))
              .and(UserNewsAction.ACTION.eq('LIKE')));
      UserNewsAction userNewsAction = userNewsActions.isNotEmpty ? userNewsActions[0] : null;
      return userNewsAction;
    } catch (e) {
      print(e);
    }
  }

  Future<List<UserNewsAction>> getUserNewsActionsByUser(User user) async {
    final userNewsActions = await Amplify.DataStore.query(
      UserNewsAction.classType,
      where: UserNewsAction.USERID.eq(user.id).and(UserNewsAction.ACTION.eq('LIKE')),
      sortBy: [UserNewsAction.UPDATEDAT.descending()],
    );
    // sort desc
    userNewsActions.sort((a, b) => b.updatedAt.compareTo(a.updatedAt));
    return userNewsActions;
  }
}
