import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:spent/presentation/AppRouter.gr.dart';
import 'package:spent/presentation/bloc/query/query_bloc.dart';
import 'package:spent/presentation/bloc/search/search_bloc.dart';
import 'package:spent/domain/model/category.dart';
import 'package:spent/domain/model/news_source.dart';
import 'package:spent/domain/model/search_item.dart';
import 'package:spent/presentation/pages/query_page.dart';
import 'package:spent/presentation/widgets/search_item_builder.dart';

typedef OnClickItem = void Function(BuildContext context, String source);

class SearchBar extends StatefulWidget {
  final FloatingSearchBarController controller = FloatingSearchBarController();

  SearchBar({Key key}) : super(key: key);

  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  FloatingSearchBarController _controller;
  SearchBloc _searchBloc;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller;
    _searchBloc = BlocProvider.of<SearchBloc>(context);
    _searchBloc.add(SearchChange(''));
  }

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
    ExtendedNavigator.of(context).push(
      Routes.queryPage,
      arguments: QueryPageArguments(
        query: category,
        queryField: QueryField.category,
        coverUrl: Category.newsCategoryCover[category],
        isShowTitle: true,
      ),
    );
  }

  void _onClickSourceItem(BuildContext context, String source) {
    ExtendedNavigator.of(context).push(
      Routes.queryPage,
      arguments: QueryPageArguments(
          query: source, queryField: QueryField.source, coverUrl: NewsSource.newsSourceCover[source]),
    );
  }

  void _onQueryChanged(String query) {
    _searchBloc.add(SearchChange(query));
  }

  Widget _buildResults({List<SearchItem> results, String type}) {
    final List<SearchItem> typeResults = results.where((item) => item.type == type).toList();
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

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchBloc, SearchState>(
      builder: (BuildContext context, SearchState state) {
        return FloatingSearchAppBar(
          elevation: 12,
          alwaysOpened: true,
          hideKeyboardOnDownScroll: true,
          controller: _controller,
          clearQueryOnClose: false,
          hintStyle: GoogleFonts.kanit(),
          hint: 'ค้นหา แหล่งข่าว, ประเภทข่าว',
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
            children: [
              _buildResults(results: state.results, type: SearchItem.source),
              Container(
                height: 16,
              ),
              _buildResults(results: state.results, type: SearchItem.category),
            ],
          ),
        );
      },
    );
  }
}
