import 'package:fuzzy/fuzzy.dart';
import 'package:spent/model/category.dart';
import 'package:spent/model/news_source.dart';
import 'package:spent/model/search_item.dart';

class SearchRepository {
  Fuzzy<SearchItem> fuse;

  List<dynamic> searchList;

  List<SearchItem> _mapToFuzzy(
      {List<String> items, String type, String description}) {
    return items
        .map((item) =>
            SearchItem(value: item, type: type, description: description))
        .toList();
  }

  SearchRepository() {
    List<SearchItem> catogoryList = _mapToFuzzy(
      items: Category.values,
      type: SearchItem.category,
      description: SearchItem.categoryDescription,
    );

    List<SearchItem> sourceList = _mapToFuzzy(
      items: NewsSource.values,
      type: SearchItem.source,
      description: SearchItem.sourceDescription,
    );

    fuse = Fuzzy(catogoryList + sourceList,
        options: FuzzyOptions(
          keys: [
            WeightedKey<SearchItem>(
                name: 'value', getter: (item) => item.value, weight: 1)
          ],
          shouldNormalize: true,
          isCaseSensitive: false,
          shouldSort: false,
          findAllMatches: false,
        ));
  }

  Future<List<SearchItem>> loadSearchResults(String query) async {
    final result = fuse.search(query);
    return Future.delayed(const Duration(milliseconds: 300),
        () => result.map((r) => r.item).toList());
  }
}
