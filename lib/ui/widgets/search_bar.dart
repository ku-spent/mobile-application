import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:spent/bloc/search/search_bloc.dart';
import 'package:spent/ui/widgets/search_item_builder.dart';

class SearchBar extends StatelessWidget {
  final FloatingSearchBarController _controller = FloatingSearchBarController();
  SearchBar({Key key}) : super(key: key);

  void _onSumitted(String query) {}

  @override
  Widget build(BuildContext context) {
    void _onQueryChanged(String query) {
      BlocProvider.of<SearchBloc>(context).add(SearchChange(query));
    }

    final actions = [
      FloatingSearchBarAction(
        showIfOpened: false,
        child: CircularButton(
          icon: const Icon(
            Icons.fiber_new_sharp,
          ),
          onPressed: () {},
        ),
      ),
      FloatingSearchBarAction.searchToClear(
        showIfClosed: false,
      ),
    ];

    return BlocBuilder<SearchBloc, SearchState>(
        builder: (BuildContext context, SearchState state) {
      return FloatingSearchAppBar(
        elevation: 12,
        alwaysOpened: true,
        hideKeyboardOnDownScroll: true,
        controller: _controller,
        clearQueryOnClose: false,
        hint: 'Search for a news...',
        iconColor: Colors.grey,
        color: Colors.white,
        colorOnScroll: Colors.white,
        liftOnScrollElevation: 4,
        transitionDuration: const Duration(milliseconds: 300),
        transitionCurve: Curves.easeInOutCubic,
        actions: actions,
        progress: state is SearchLoading,
        debounceDelay: const Duration(milliseconds: 500),
        onQueryChanged: _onQueryChanged,
        onSubmitted: _onSumitted,
        body: ListView(
          children: [SearchItemBuilder(results: state.results)],
        ),
      );
    });
  }
}
