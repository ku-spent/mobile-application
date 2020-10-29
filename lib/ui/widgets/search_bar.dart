import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:spent/bloc/query/query_bloc.dart';
import 'package:spent/bloc/search/search_bloc.dart';
import 'package:spent/model/news.dart';
import 'package:spent/model/search_item.dart';
import 'package:spent/ui/pages/query_page.dart';
import 'package:spent/ui/widgets/search_item_builder.dart';

typedef OnClickItem = void Function(BuildContext context, String source);

class SearchBar extends StatelessWidget {
  final FloatingSearchBarController _controller = FloatingSearchBarController();

  SearchBar({Key key}) : super(key: key);

  void _onSumitted(String query) {}

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

  void _onClickCategoryItem(BuildContext context, String category) {
    Navigator.push(
      context,
      MaterialPageRoute(
        maintainState: false,
        builder: (context) => QueryPage(
          query: category,
          queryField: QueryField.category,
          coverUrl: '',
        ),
      ),
    );
  }

  void _onClickSourceItem(BuildContext context, String source) {
    Navigator.push(
      context,
      MaterialPageRoute(
        maintainState: false,
        builder: (context) => QueryPage(
          query: source,
          queryField: QueryField.source,
          coverUrl: NewsSource.newsSourceCover[source],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    void _onQueryChanged(String query) {
      BlocProvider.of<SearchBloc>(context).add(SearchChange(query));
    }

    Widget _buildResults({List<SearchItem> results, String type}) {
      final List<SearchItem> typeResults =
          results.where((item) => item.type == type).toList();
      OnClickItem _onClick;

      if (type == SearchItem.category)
        _onClick = _onClickCategoryItem;
      else if (type == SearchItem.source) _onClick = _onClickSourceItem;

      return SearchItemBuilder(
        results: typeResults,
        title: type,
        onClick: (String query) => _onClick(context, query),
      );
    }

    return BlocBuilder<SearchBloc, SearchState>(
      builder: (BuildContext context, SearchState state) {
        return FloatingSearchAppBar(
          elevation: 12,
          alwaysOpened: true,
          hideKeyboardOnDownScroll: true,
          controller: _controller,
          clearQueryOnClose: false,
          hintStyle: GoogleFonts.kanit(),
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
          body: state.results.isEmpty
              ? Center(
                  child: Text('Search'),
                )
              : ListView(
                  children: [
                    _buildResults(
                        results: state.results, type: SearchItem.source),
                    Container(
                      height: 16,
                    ),
                    _buildResults(
                        results: state.results, type: SearchItem.category),
                  ],
                ),
        );
      },
    );
  }
}
