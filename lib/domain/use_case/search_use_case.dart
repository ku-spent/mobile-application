import 'package:injectable/injectable.dart';
import 'package:spent/data/repository/search_repository.dart';
import 'package:spent/domain/model/search_item.dart';

@injectable
class SearchUseCase {
  SearchRepository _searchRepository;
  SearchUseCase(this._searchRepository);

  Future<List<SearchItem>> call(String query) async => _searchRepository.getSearchResults(query);
}
