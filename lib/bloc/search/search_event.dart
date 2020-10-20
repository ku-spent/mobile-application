part of 'search_bloc.dart';

@immutable
abstract class SearchEvent extends Equatable {
  const SearchEvent();

  @override
  List<Object> get props => [];
}

class SearchLoad extends SearchEvent {
  @override
  List<Object> get props => [];
}

class SearchChange extends SearchEvent {
  final String query;

  const SearchChange(this.query);

  @override
  List<Object> get props => [query];

  @override
  String toString() {
    return 'LoadResults';
  }
}
