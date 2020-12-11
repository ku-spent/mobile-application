import 'package:injectable/injectable.dart';
import 'package:spent/data/repository/authentication_repository.dart';
import 'package:spent/data/repository/news_repository.dart';
import 'package:spent/domain/model/news.dart';

@injectable
class GetNewsFeedUseCase {
  final NewsRepository _newsRepository;
  final AuthenticationRepository _authenticationRepository;

  const GetNewsFeedUseCase(this._newsRepository, this._authenticationRepository);

  Future<List<News>> call({
    int from = 0,
    int size = 5,
    String queryField = '_',
    String query,
  }) async {
    // final isValidSession = await _authenticationRepository.isValidSession();
    return _newsRepository.getNewsFromRemote(from, size, queryField, query);
  }
}
