import 'package:amplify_core/amplify_core.dart';
import 'package:injectable/injectable.dart';
import 'package:spent/domain/model/History.dart';
import 'package:spent/domain/model/news.dart';
import 'package:spent/domain/model/user.dart';

@singleton
class UserStorage {
  UserStorage();

  Future<History> saveNewsHistory(User user, News news) async {
    History history = History(newId: news.id, userId: user.id);
    await Amplify.DataStore.save(history);
  }
}
