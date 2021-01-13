import 'package:injectable/injectable.dart';
import 'package:spent/data/data_source/search_item/search_local_data_source.dart';
import 'package:spent/data/data_source/search_item/search_remote_data_source.dart';
import 'package:spent/domain/model/ModelProvider.dart';
import 'package:spent/domain/model/search_item.dart';
import 'package:spent/domain/model/search_result.dart';

@injectable
class SearchRepository {
  final SearchRemoteDataSource _searchRemoteDataSource;
  final SearchLocalDataSource _searchLocalDataSource;

  SearchRepository(this._searchRemoteDataSource, this._searchLocalDataSource);

  Future<SearchResult> getSearchResults(String query) async {
    final List<SearchItem> localSearchItemList = await _searchLocalDataSource.getSearchItems(query);
    final List<News> remoteSearchNewsList = query == '' ? [] : await _searchRemoteDataSource.getSearchItems(query);
    final List<SearchItem> categories = localSearchItemList.where((e) => e.type == SearchItem.category).toList();
    final List<SearchItem> sources = localSearchItemList.where((e) => e.type == SearchItem.source).toList();
    final SearchResult searchResult = SearchResult(
      news: remoteSearchNewsList,
      categories: categories,
      sources: sources,
    );
    return searchResult;
  }
}
