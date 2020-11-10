import 'package:injectable/injectable.dart';
import 'package:spent/data/data_source/search_item/search_item_data_source.dart';
import 'package:spent/domain/model/search_item.dart';

@injectable
class SearchRepository {
  final SearchItemDataSource _searchDataSource;

  SearchRepository(this._searchDataSource);

  Future<List<SearchItem>> getSearchResults(String query) async =>
      _searchDataSource.getSearchItems(query);
}
