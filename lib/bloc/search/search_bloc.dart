import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc() : super(SearchInitial());

  @override
  Stream<SearchState> mapEventToState(
    SearchEvent event,
  ) async* {
    if (event is LoadResults) {
      yield* _mapLoadResultsState();
    }
  }

  Stream<SearchState> _mapLoadResultsState() async* {
    try {
      // final todos = await FileStorage().loadTodos();
      yield SearchLoaded([]);
    } catch (_) {
      yield SearchNotLoaded();
    }
  }
}
