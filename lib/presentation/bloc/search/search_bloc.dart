import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:flutter/widgets.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import 'package:spent/domain/model/search_result.dart';
import 'package:spent/domain/use_case/search_use_case.dart';

part 'search_event.dart';
part 'search_state.dart';

@injectable
class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final SearchUseCase _searchUseCase;
  final int fetchSize = 10;

  SearchBloc(this._searchUseCase) : super(SearchInitial());

  @override
  Stream<SearchState> mapEventToState(
    SearchEvent event,
  ) async* {
    if (event is SearchChange) {
      yield* _mapLoadResultsState(event.query);
    } else if (event is SearchLoad) {
      yield* _mapLoadingResultsState();
    } else if (event is LoadMoreNewsResults) {
      yield* _mapLoadMoreNewsResultsState(event);
    }
  }

  Stream<SearchState> _mapLoadingResultsState() async* {
    yield SearchLoading();
  }

  Stream<SearchState> _mapLoadMoreNewsResultsState(LoadMoreNewsResults event) async* {
    try {
      final curState = state;
      if (curState is SearchLoaded && curState.hasMore) {
        final loadedResults = await _searchUseCase.call(curState.query, fetchSize, curState.result.news.length);

        yield loadedResults.news.isEmpty
            ? curState.copyWith(hasMore: false)
            : SearchLoaded(
                curState.result.copyWith(curState.result.news + loadedResults.news),
                curState.query,
                hasMore: true,
              );
      }
    } catch (e) {
      yield SearchNotLoaded();
    }
  }

  Stream<SearchState> _mapLoadResultsState(String query) async* {
    yield SearchLoading(result: state.result);
    try {
      final results = await _searchUseCase.call(query, fetchSize, 0);
      yield SearchLoaded(results, query, hasMore: results.news.isNotEmpty);
    } catch (e) {
      yield SearchNotLoaded();
    }
  }

  @override
  Stream<Transition<SearchEvent, SearchState>> transformEvents(Stream<SearchEvent> events, transitionFn) {
    return super.transformEvents(events.debounceTime(const Duration(milliseconds: 500)), transitionFn);
  }
}
