import 'package:injectable/injectable.dart';
import 'package:spent/data/repository/news_repository.dart';
import 'package:spent/domain/model/News.dart';

@injectable
class GetNewsByIdUseCase {
  final NewsRepository _newsRepository;

  const GetNewsByIdUseCase(this._newsRepository);

  Future<News> call(String id) async {
    return _newsRepository.getNewsById(id);
  }
}
