part of 'search_bloc.dart';

abstract class SearchState extends Equatable {
  final String query;
  final List<SearchItem> results;

  const SearchState(this.results, this.query);

  @override
  List<Object> get props => [results];
}

class SearchInitial extends SearchState {
  const SearchInitial() : super(const [], '');
}

class SearchLoading extends SearchState {
  const SearchLoading({List<SearchItem> results}) : super(results, '');

  @override
  String toString() => 'SearchLoading';
}

class SearchLoaded extends SearchState {
  SearchLoaded(List<SearchItem> results, String query) : super(results, query);

  @override
  String toString() {
    return 'SearchLoaded { Search : $results }';
  }

  @override
  List<Object> get props => [results];
}

class SearchNotLoaded extends SearchState {
  const SearchNotLoaded() : super(const [], '');

  @override
  String toString() => 'SearchNotLoaded';
}
