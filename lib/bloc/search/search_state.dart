part of 'search_bloc.dart';

abstract class SearchState extends Equatable {
  const SearchState();

  @override
  List<Object> get props => [];
}

class SearchInitial extends SearchState {}

class SearchLoading extends SearchState {
  @override
  String toString() => 'SearchLoading';
}

class SearchLoaded extends SearchState {
  final List<dynamic> results;

  SearchLoaded(this.results) : super();

  @override
  String toString() {
    return 'SearchLoaded { Search : $results }';
  }

  @override
  List<Object> get props => [results];
}

class SearchNotLoaded extends SearchState {
  @override
  String toString() => 'SearchNotLoaded';
}
