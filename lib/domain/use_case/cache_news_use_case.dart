import 'package:injectable/injectable.dart';
import 'package:spent/data/repository/news_repository.dart';
import 'package:spent/domain/model/news.dart';

@injectable
class CacheNewsUseCase {
  final NewsRepository _newsRepository;

  const CacheNewsUseCase(this._newsRepository);

  Future<void> call(List<News> newsList) async {
    await _newsRepository.cacheNews(newsList);
  }
}
