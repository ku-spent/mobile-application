import 'package:amplify_core/amplify_core.dart';
import 'package:amplify_datastore_plugin_interface/amplify_datastore_plugin_interface.dart';
import 'package:injectable/injectable.dart';
import 'package:spent/domain/model/History.dart';
import 'package:spent/domain/model/ModelProvider.dart';
import 'package:spent/domain/model/news.dart';
import 'package:spent/domain/model/User.dart';

@singleton
class UserStorage {
  const UserStorage();

  Future<void> saveNewsHistory(User user, News news) async {
    final history = History(
      newId: news.id,
      // userId: user.id,
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
    print('get');
    try {
      History history = (await Amplify.DataStore.query(
        History.classType,
        where: History.USER.eq(user.id).and(History.NEWID.eq(news.id)),
      ))[0];
      print(history);
      return history;
    } catch (err) {
      print(err);
    }
  }

  Future<List<History>> getNewsHistory(User user) async {
    print(History.CREATEDAT.descending().field);
    final histories = await Amplify.DataStore.query(
      History.classType,
      where: History.USER.eq(user.id).and(History.STATUS.eq('ACTIVE')),
      sortBy: [History.UPDATEDAT.descending()],
      // pagination: QueryPagination(page: 0, limit: 3),
    );

    return histories;
  }
}
