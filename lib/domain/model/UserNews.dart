import 'package:spent/data/data_source/user_storage/user_storage.dart';
import 'package:spent/domain/model/ModelProvider.dart';

class UserNews {
  final User user;
  final News news;
  final UserStorage _userStorage;
  bool isBookmarked;
  bool isLiked;

  UserNews(this.user, this.news, this._userStorage);

  Future<void> init() async {
    this.isBookmarked = false;
    this.isLiked = false;
  }
}
