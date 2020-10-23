import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:spent/model/search_result.dart';
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
    yield SearchLoading();
    try {
      final List<SearchResult> results =
          await searchRepository.loadSearchResults();
      yield SearchLoaded(results, query);
    } catch (_) {
      yield SearchNotLoaded();
    }
  }
}
