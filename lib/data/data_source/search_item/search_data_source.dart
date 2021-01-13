import 'package:spent/domain/model/search_item.dart';

abstract class SearchItemDataSource {
  Future<List<SearchItem>> getSearchItems(String query);
}
