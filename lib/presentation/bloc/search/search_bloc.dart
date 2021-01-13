import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:injectable/injectable.dart';
import 'package:spent/domain/model/search_result.dart';
import 'package:spent/domain/use_case/search_use_case.dart';

part 'search_event.dart';
part 'search_state.dart';

@injectable
class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final SearchUseCase _searchUseCase;

  SearchBloc(this._searchUseCase) : super(SearchInitial());

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
    yield SearchLoading(result: state.result);
    try {
      final results = await _searchUseCase.call(query);
      yield SearchLoaded(results, query);
    } catch (e) {
      yield SearchNotLoaded();
    }
  }
}
