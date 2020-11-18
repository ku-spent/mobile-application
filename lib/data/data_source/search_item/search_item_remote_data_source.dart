import 'package:injectable/injectable.dart';
import 'package:spent/data/data_source/search_item/search_item_data_source.dart';
import 'package:spent/data/data_source/search_item/search_item_fuse.dart';
import 'package:spent/domain/model/search_item.dart';

@Injectable(as: SearchItemDataSource)
class SearchRemoteDataSource implements SearchItemDataSource {
  SearchItemFuse _fuse;

  SearchRemoteDataSource(this._fuse);

  @override
  Future<List<SearchItem>> getSearchItems(String query) async {
    final results = _fuse.search(query);
    final formatted = Future.delayed(const Duration(milliseconds: 300), () => results.map((r) => r.item).toList());
    print(formatted);
    return formatted;
  }
}
