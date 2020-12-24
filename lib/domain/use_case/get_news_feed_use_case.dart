import 'package:injectable/injectable.dart';
import 'package:spent/data/repository/news_repository.dart';
import 'package:spent/domain/model/News.dart';

@injectable
class GetNewsFeedUseCase {
  final NewsRepository _newsRepository;

  const GetNewsFeedUseCase(this._newsRepository);

  Future<List<News>> call({
    int from = 0,
    int size = 5,
    String queryField = '_',
    String query,
    bool isRemote = false,
  }) async {
    if (isRemote) {
      print('get feed from remote');
      return _newsRepository.getNewsFromRemote(from, size, queryField, query);
    } else {
      print('get feed from local');
      return _newsRepository.getNewsFromLocal(from, size, queryField, query);
    }
  }
}
