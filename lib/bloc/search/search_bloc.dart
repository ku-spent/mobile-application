import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:spent/model/search_item.dart';
import 'package:spent/repository/search_repository.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchRepository searchRepository = SearchRepository();

  SearchBloc() : super(SearchInitial());

  @override
  Stream<SearchState> mapEventToState(
    SearchEvent event,
  ) async* {
    if (event is SearchChange) {
      yield* _mapLoadResultsState(event.query);
    } else if (event is SearchLoad) {
      yield* _mapLoadingResultsState();
    }
  }

  Stream<SearchState> _mapLoadingResultsState() async* {
    yield SearchLoading();
  }

  Stream<SearchState> _mapLoadResultsState(String query) async* {
    yield SearchLoading(results: state.results);
    try {
      final List<SearchItem> results =
          await searchRepository.loadSearchResults(query);
      yield SearchLoaded(results, query);
    } catch (_) {
      yield SearchNotLoaded();
    }
  }
}
