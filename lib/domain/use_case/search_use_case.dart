import 'package:injectable/injectable.dart';
import 'package:spent/data/repository/search_repository.dart';
import 'package:spent/domain/model/search_result.dart';

@injectable
class SearchUseCase {
  SearchRepository _searchRepository;
  SearchUseCase(this._searchRepository);

  Future<SearchResult> call(String query, int size, int from) async =>
      _searchRepository.getSearchResults(query, size: size, from: from);
}
