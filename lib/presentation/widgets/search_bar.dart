import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'package:spent/domain/model/ModelProvider.dart';
import 'package:spent/presentation/AppRouter.gr.dart';
import 'package:spent/presentation/bloc/query/query_bloc.dart';
import 'package:spent/presentation/bloc/search/search_bloc.dart';
import 'package:spent/domain/model/category.dart';
import 'package:spent/domain/model/news_source.dart';
import 'package:spent/domain/model/search_item.dart';
import 'package:spent/presentation/widgets/card_base.dart';
import 'package:spent/presentation/widgets/no_result.dart';
import 'package:spent/presentation/widgets/search_item_Builder.dart';
import 'package:spent/presentation/widgets/search_item_List.dart';

typedef OnClickItem = void Function(BuildContext context, String source);

class SearchBar extends StatefulWidget {
  final FloatingSearchBarController controller = FloatingSearchBarController();

  SearchBar({Key key}) : super(key: key);

  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  final _scrollThreshold = 200.0;
  final RefreshController _refreshController = RefreshController();

  SearchBloc _searchBloc;
  FloatingSearchBarController _controller;
  ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller;
    _searchBloc = BlocProvider.of<SearchBloc>(context);
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);
    _searchBloc.add(SearchChange(''));
  }

  void _onScroll() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    if (maxScroll - currentScroll <= _scrollThreshold) {
      _loadMoreNewsResults();
    }
  }

  void _onSumitted(String query) {}

  void _loadMoreNewsResults() {
    _searchBloc.add(LoadMoreNewsResults());
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

  void _onClickCategoryItem(String category) {
    ExtendedNavigator.of(context).push(
      Routes.queryPage,
      arguments: QueryPageArguments(
        query: QueryWithField(category, query: category, queryField: QueryField.category),
        coverUrl: Category.newsCategoryCover[category],
        isShowTitle: true,
      ),
    );
  }

  void _onClickSourceItem(String source) {
    ExtendedNavigator.of(context).push(
      Routes.queryPage,
      arguments: QueryPageArguments(
        query: QueryWithField(source, query: source, queryField: QueryField.source),
        coverUrl: NewsSource.newsSourceCover[source],
      ),
    );
  }

  void _onQueryChanged(String query) {
    _searchBloc.add(SearchChange(query));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchBloc, SearchState>(
      builder: (BuildContext context, SearchState state) {
        return FloatingSearchAppBar(
          elevation: 1,
          alwaysOpened: true,
          controller: _controller,
          clearQueryOnClose: false,
          hintStyle: GoogleFonts.kanit(),
          hint: 'ค้นหา ข่าว, แหล่งข่าว, ประเภทข่าว',
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
          body: SmartRefresher(
            enablePullDown: false,
            physics: const BouncingScrollPhysics(),
            controller: _refreshController,
            enablePullUp: state is SearchLoaded ? state.hasMore : false,
            child: ListView(
              controller: _scrollController,
              children: [
                state.result.sources.isEmpty &&
                        state.result.categories.isEmpty &&
                        state.result.news.isEmpty &&
                        state is! SearchLoading &&
                        state is! SearchInitial
                    ? NoResult()
                    : Container(),
                Padding(
                  padding: EdgeInsets.only(bottom: state.result.sources.length > 0 ? 16.0 : 0.0),
                  child: SearchItemList<SearchItem>(
                    results: state.result.sources,
                    title: SearchItem.source,
                    itemBuilder: (result) => SearchItemBuilder(
                      result: result,
                      onClick: _onClickSourceItem,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: state.result.categories.length > 0 ? 16.0 : 0.0),
                  child: SearchItemList<SearchItem>(
                    results: state.result.categories,
                    title: SearchItem.category,
                    itemBuilder: (result) => SearchItemBuilder(
                      result: result,
                      onClick: _onClickCategoryItem,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 0.0),
                  child: SearchItemList<News>(
                    results: state.result.news,
                    title: SearchItem.news,
                    itemBuilder: (result) => CardBase(key: ValueKey(result.id), news: result),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
