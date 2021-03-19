import 'package:spent/domain/model/Following.dart';
import 'package:spent/domain/model/ModelProvider.dart';

abstract class FollowingDataSource {
  Future<List<Following>> getFollowingList(User user);

  Future<Following> addFollowing(User user, Following following);

  Future<void> saveFollowingList(User user, List<Following> followingList);

  Future<void> deleteFollowing(User user, Following following);
}
