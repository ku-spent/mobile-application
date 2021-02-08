import 'package:fuzzy/data/result.dart';
import 'package:fuzzy/fuzzy.dart';
import 'package:injectable/injectable.dart';
import 'package:spent/domain/model/category.dart';
import 'package:spent/domain/model/news_source.dart';
import 'package:spent/domain/model/search_item.dart';

@injectable
class SearchItemFuse {
  Fuzzy<SearchItem> fuse;

  List<SearchItem> _mapToFuzzy({List<String> items, String type, String description}) {
    return items.map((item) => SearchItem(value: item, type: type, description: description)).toList();
  }

  SearchItemFuse() {
    final List<SearchItem> catogoryList = _mapToFuzzy(
      items: Category.values,
      type: SearchItem.category,
      description: SearchItem.categoryDescription,
    );

    final List<SearchItem> sourceList = _mapToFuzzy(
      items: NewsSource.values,
      type: SearchItem.source,
      description: SearchItem.sourceDescription,
    );
    fuse = Fuzzy(catogoryList + sourceList,
        options: FuzzyOptions(
          keys: [WeightedKey<SearchItem>(name: 'value', getter: (item) => item.value, weight: 1)],
          shouldNormalize: true,
          isCaseSensitive: false,
          shouldSort: false,
          findAllMatches: false,
        ));
  }

  List<Result<SearchItem>> search(String query) {
    return fuse.search(query);
  }
}
