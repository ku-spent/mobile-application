import 'package:injectable/injectable.dart';
import 'package:spent/data/data_source/search_item/search_data_source.dart';
import 'package:spent/data/data_source/search_item/search_item_fuse.dart';
import 'package:spent/domain/model/search_item.dart';

@injectable
class SearchLocalDataSource implements SearchItemDataSource {
  final SearchItemFuse _fuse;

  const SearchLocalDataSource(this._fuse);

  @override
  Future<List<SearchItem>> getSearchItems(String query) async {
    final results = _fuse.search(query);
    final formatted = Future.delayed(const Duration(milliseconds: 300), () => results.map((r) => r.item).toList());
    return formatted;
  }
}
