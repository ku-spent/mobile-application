import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:spent/data/repository/authentication_repository.dart';
import 'package:spent/data/repository/news_repository.dart';
import 'package:spent/data/repository/user_repository.dart';
import 'package:spent/domain/model/ModelProvider.dart';

@injectable
class GetNewsFeedTrendUseCase {
  final NewsRepository _newsRepository;
  final UserRepository _userRepository;
  final AuthenticationRepository _authenticationRepository;

  const GetNewsFeedTrendUseCase(this._newsRepository, this._userRepository, this._authenticationRepository);

  Future<List<News>> call({
    @required String trend,
    int from = 0,
    int size = 5,
    bool isRemote = false,
  }) async {
    final User user = await _authenticationRepository.getCurrentUser();
    // TODO: implement local trend
    final List<News> newsList = isRemote ? await _newsRepository.getNewsRelatedTrend(trend, from, size) : null;
    final List<News> mappedUserNews =
        await Future.wait(newsList.map((news) => _userRepository.mapUserActionToNews(user, news)));
    return mappedUserNews;
  }
}
