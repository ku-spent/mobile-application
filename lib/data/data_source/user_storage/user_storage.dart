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
    print('get');
    try {
      History history = (await Amplify.DataStore.query(
        History.classType,
        where: QueryPredicateOperation('user.id', EqualQueryOperator(user.id)).and(History.NEWID.eq(news.id)),
      ))[0];
      return history;
    } catch (err) {
      print(err);
    }
  }

  Future<List<History>> getNewsHistory(User user) async {
    final histories = await Amplify.DataStore.query(
      History.classType,
      where: QueryPredicateOperation('user.id', EqualQueryOperator(user.id)).and(History.STATUS.eq('ACTIVE')),
      sortBy: [History.UPDATEDAT.descending()],
    );
    // sort desc
    histories.sort((a, b) => b.updatedAt.compareTo(a.updatedAt));

    return histories;
  }
}
