part of 'search_bloc.dart';

abstract class SearchState extends Equatable {
  final String query;
  final SearchResult result;

  const SearchState(this.result, this.query);

  @override
  List<Object> get props => [result];
}

class SearchInitial extends SearchState {
  const SearchInitial() : super(const SearchResult(news: [], categories: [], sources: []), '');
}

class SearchLoading extends SearchState {
  const SearchLoading({SearchResult result}) : super(result, '');

  @override
  String toString() => 'SearchLoading';
}

class SearchLoaded extends SearchState {
  SearchLoaded(SearchResult result, String query) : super(result, query);

  @override
  String toString() {
    return 'SearchLoaded { Search : $result }';
  }

  @override
  List<Object> get props => [result];
}

class SearchNotLoaded extends SearchState {
  const SearchNotLoaded() : super(const SearchResult(news: [], categories: [], sources: []), '');

  @override
  String toString() => 'SearchNotLoaded';
}
