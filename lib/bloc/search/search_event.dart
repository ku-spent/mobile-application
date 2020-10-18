part of 'search_bloc.dart';

@immutable
abstract class SearchEvent extends Equatable {
  const SearchEvent();

  @override
  List<Object> get props => [];
}

class LoadResults extends SearchEvent {
  @override
  String toString() {
    return 'LoadResults';
  }
}
