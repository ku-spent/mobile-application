import 'dart:convert';
import 'dart:typed_data';

import 'package:amplify_api/amplify_api.dart';
import 'package:injectable/injectable.dart';
import 'package:spent/data/data_source/following/following_data_source.dart';
import 'package:spent/data/http_manager/amplify_http_manager.dart';
import 'package:spent/domain/model/Following.dart';
import 'package:spent/domain/model/ModelProvider.dart';

@injectable
class FollowingRemoteDataSource implements FollowingDataSource {
  final AmplifyHttpManager _httpManager;

  const FollowingRemoteDataSource(this._httpManager);

  @override
  Future<List<Following>> getFollowingList(User user) async {
    try {
      final RestOptions restOptions = RestOptions(
        path: "/users/${user.id}/following",
      );
      final Map<String, dynamic> response = await _httpManager.get(restOptions);
      final List items = response['data'];
      if (items == null) return const [];
      final List<Following> followingList = items.map((e) => Following.fromJson(e)).toList();
      return followingList;
    } catch (e) {
      print(e);
      throw e;
    }
  }

  @override
  Future<void> deleteFollowing(User user, Following following) async {
    try {
      final RestOptions restOptions = RestOptions(
        path: "/users/${user.id}/following",
        queryParameters: {"itemID": following.id},
      );
      final Map<String, dynamic> response = await _httpManager.delete(restOptions);
      print(response['data']);
    } catch (e) {
      print(e);
      throw e;
    }
  }

  @override
  Future<Following> addFollowing(User user, Following following) async {
    try {
      final RestOptions restOptions = RestOptions(
        path: "/users/${user.id}/following",
        body: Uint8List.fromList(utf8.encode(json.encode(following.toJson()))),
      );
      final Map<String, dynamic> response = await _httpManager.post(restOptions);
      print(response['data']);
      final Following resFollowing = Following.fromJson(response['data']);
      return resFollowing;
    } catch (e) {
      print(e);
      throw e;
    }
  }

  @override
  Future<void> saveFollowingList(User user, List<Following> followingList) async {
    try {
      final RestOptions restOptions = RestOptions(
        path: "/users/${user.id}/following",
        body: Uint8List.fromList(
            utf8.encode(json.encode({'followingItems': followingList.map((e) => e.toJson()).toList()}))),
      );
      final Map<String, dynamic> response = await _httpManager.put(restOptions);
      print(response['data']);
    } catch (e) {
      print(e);
      throw e;
    }
  }
}
