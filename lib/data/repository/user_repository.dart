import 'package:injectable/injectable.dart';
import 'package:spent/data/data_source/following/following_remote_data_source.dart';
import 'package:spent/domain/model/Following.dart';

import 'package:spent/helper/pagination.dart';
import 'package:spent/domain/model/ModelProvider.dart';
import 'package:spent/data/data_source/user_storage/user_storage.dart';

@singleton
class UserRepository {
  final UserStorage _userStorage;
  final FollowingRemoteDataSource _followingRemoteDataSource;

  const UserRepository(this._userStorage, this._followingRemoteDataSource);

  Future<News> mapUserActionToNews(User user, News news) async {
    final Bookmark bookmark = await getBookmarkByNewsId(user, news);
    final UserNewsAction userNewsAction = await getUserNewsActionByNewsId(user, news);
    news.isBookmarked = bookmark != null;
    news.userAction =
        userNewsAction != null && userNewsAction.action == UserAction.LIKE ? UserAction.LIKE : UserAction.NONE;
    return news;
  }

  // BLock
  Future<List<Block>> getBlocksByUser(User user, {String query, PaginationOption paginationOption}) async {
    return _userStorage.getBlocksByUser(user, query: query, paginationOption: paginationOption);
  }

  Future<Block> getBlocksByUserAndName(User user, String name) async {
    return _userStorage.getBlocksByUserAndName(user, name);
  }

  Future<void> saveBlock(User user, String name, BlockTypes type) async {
    await _userStorage.saveBlock(user, name, type);
  }

  Future<void> deleteBlock(Block block) async {
    await _userStorage.deleteBlock(block);
  }

  // History
  Future<void> saveNewsHistory(User user, News news) async {
    await _userStorage.saveNewsHistory(user, news);
  }

  Future<void> updateNewsHistory(History oldHistory, History newHistory) async {
    await _userStorage.updateNewsHistory(oldHistory, newHistory);
  }

  Future<void> deleteNewsHistory(History history) async {
    await _userStorage.deleteNewsHistory(history);
  }

  Future<History> getHistoryByNewsId(User user, News news) async {
    final history = await _userStorage.getHistoryByNewsId(user, news);
    return history;
  }

  Future<List<History>> getNewsHistoryByUser(User user, {String query, PaginationOption paginationOption}) async {
    final histories = await _userStorage.getNewsHistoryByUser(user, query: query, paginationOption: paginationOption);
    return histories;
  }

  // Bookmark
  Future<void> saveBookmark(User user, News news) async {
    await _userStorage.saveBookmark(user, news);
  }

  Future<void> deleteBookmark(Bookmark bookmark) async {
    await _userStorage.deleteBookmark(bookmark);
  }

  Future<Bookmark> getBookmarkByNewsId(User user, News news) async {
    final bookmark = await _userStorage.getBookmarkByNewsId(user, news);
    return bookmark;
  }

  Future<List<Bookmark>> getBookmarksByUser(User user, {String query, PaginationOption paginationOption}) async {
    final bookmarks = await _userStorage.getBookmarksByUser(user, query: query, paginationOption: paginationOption);
    return bookmarks;
  }

  // UserNewsAction
  Future<void> saveUserNewsAction(User user, News news) async {
    await _userStorage.saveUserNewsAction(user, news);
  }

  Future<void> deleteUserNewsAction(UserNewsAction userNewsAction) async {
    await _userStorage.deleteUserNewsAction(userNewsAction);
  }

  Future<UserNewsAction> getUserNewsActionByNewsId(User user, News news) async {
    final userNewsAction = await _userStorage.getUserNewsActionByNewsId(user, news);
    return userNewsAction;
  }

  Future<List<UserNewsAction>> getUserNewsActionsByUser(User user) async {
    final userNewsActions = await _userStorage.getUserNewsActionsByUser(user);
    return userNewsActions;
  }

  Future<List<Following>> getFollowingList(User user) async {
    return await _followingRemoteDataSource.getFollowingList(user);
  }

  Future<Following> addFollowing(User user, Following following) async {
    return await _followingRemoteDataSource.addFollowing(user, following);
  }

  Future<void> saveFollowingList(User user, List<Following> followingList) async {
    return await _followingRemoteDataSource.saveFollowingList(user, followingList);
  }

  Future<void> deleteFollowing(User user, Following following) async {
    return await _followingRemoteDataSource.deleteFollowing(user, following);
  }
}
