import 'package:injectable/injectable.dart';
import 'package:spent/data/repository/news_repository.dart';
import 'package:spent/domain/model/news.dart';

@injectable
class GetNewsFeedUseCase {
  final NewsRepository _newsRepository;
  GetNewsFeedUseCase(this._newsRepository);

  Future<List<News>> call({
    int from = 0,
    int size = 5,
    String queryField = '_',
    String query,
  }) async {
    return _newsRepository.getNews(
        from: from, size: size, queryField: queryField, query: query);
  }
}
