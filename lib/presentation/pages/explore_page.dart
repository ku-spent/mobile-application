import 'package:auto_route/auto_route.dart';
import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:implicitly_animated_reorderable_list/transitions.dart';
import 'package:implicitly_animated_reorderable_list/implicitly_animated_reorderable_list.dart';

import 'package:spent/domain/model/category.dart';
import 'package:spent/domain/model/news_source.dart';
import 'package:spent/domain/model/trending_topic.dart';
import 'package:spent/presentation/AppRouter.gr.dart';
import 'package:spent/presentation/bloc/explore/explore_bloc.dart';
import 'package:spent/presentation/bloc/query/query_bloc.dart';
import 'package:spent/presentation/widgets/card_base.dart';
import 'package:spent/presentation/widgets/retry_error.dart';
import 'package:spent/presentation/widgets/section.dart';
import 'package:spent/presentation/widgets/source_icon.dart';

class ExplorePage extends StatefulWidget {
  static String title = 'Explore';
  final ScrollController scrollController;

  ExplorePage({Key key, @required this.scrollController}) : super(key: key);

  @override
  _ExplorePageState createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> with AutomaticKeepAliveClientMixin<ExplorePage> {
  ExploreBloc _feedBloc;
  ScrollController _scrollController;

  final _scrollThreshold = 200.0;
  final RefreshController _refreshController = RefreshController();

  @override
  void initState() {
    _feedBloc = BlocProvider.of<ExploreBloc>(context);
    _scrollController = widget.scrollController;
    _scrollController.addListener(_onScroll);
    _fetchExplore();
    super.initState();
  }

  void _onClickSearch(context) {
    ExtendedNavigator.of(context).push(Routes.searchPage);
  }

  @override
  bool get wantKeepAlive => true;

  void _fetchExplore() {
    _feedBloc.add(FetchExplore());
  }

  void _onScroll() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    if (maxScroll - currentScroll <= _scrollThreshold) {
      _fetchExplore();
    }
  }

  void _onRefresh() async {
    _feedBloc.add(RefreshExplore(callback: () => {_refreshController.refreshCompleted()}));
  }

  Widget _buildItem({TrendingTopic trendingTopic, int i = -1}) {
    return Section(
      title: trendingTopic.topic,
      onSeeMore: () {
        ExtendedNavigator.of(context).push(
          Routes.queryPage,
          arguments: QueryPageArguments(
            query: QueryWithTrend(trendingTopic.topic, trend: trendingTopic.topic),
            coverUrl: Category.newsCategoryCover[trendingTopic.newsList[0].category],
            isShowTitle: true,
          ),
        );
      },
      child: Column(
        children: [CardBase(news: trendingTopic.newsList[0])] +
            trendingTopic.newsList
                .sublist(1)
                .map((news) => CardBase(
                      news: news,
                      isSecondary: true,
                    ))
                .toList(),
      ),
    );
  }

  Widget _buildTags(List<String> topics) {
    return Section(
      title: 'ยอดนิยม',
      hasSeeMore: false,
      child: Container(
        padding: EdgeInsets.all(12.0),
        child: Wrap(
          spacing: 5.0,
          runSpacing: 5.0,
          children: topics
              .map(
                (tag) => InkWell(
                    splashColor: Colors.blue.withAlpha(30),
                    child: Badge(
                      elevation: 0,
                      toAnimate: false,
                      shape: BadgeShape.square,
                      badgeColor: Theme.of(context).primaryColorLight,
                      borderRadius: BorderRadius.circular(16),
                      badgeContent: Text(tag, style: GoogleFonts.kanit(color: Colors.black87)),
                    ),
                    onTap: () {
                      ExtendedNavigator.of(context).push(
                        Routes.queryPage,
                        arguments: QueryPageArguments(
                            query: QueryWithField(tag, query: tag, queryField: QueryField.tags),
                            isShowTitle: true,
                            coverUrl: Category.newsCategoryCover[Category.localNews]),
                      );
                    }),
              )
              .toList(),
        ),
      ),
    );
  }

  void _goToQuerySourcePage(String source) {
    ExtendedNavigator.of(context).push(
      Routes.queryPage,
      arguments: QueryPageArguments(
        query: QueryWithField(source, query: source, queryField: QueryField.source),
        coverUrl: NewsSource.newsSourceCover[source],
        isShowTitle: true,
      ),
    );
  }

  void _goToQueryCategoryPage(String category) {
    ExtendedNavigator.of(context).push(
      Routes.queryPage,
      arguments: QueryPageArguments(
        query: QueryWithField(category, query: category, queryField: QueryField.category),
        isShowTitle: true,
        coverUrl: Category.newsCategoryCover[category],
      ),
    );
  }

  Widget _buildSource(String source) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[100]),
        borderRadius: BorderRadius.all(Radius.circular(12.0)),
      ),
      width: 100.0,
      height: 90.0,
      margin: EdgeInsets.symmetric(horizontal: 4.0),
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
          borderRadius: BorderRadius.all(Radius.circular(12.0)),
          onTap: () => _goToQuerySourcePage(source),
          splashColor: Colors.blue.withAlpha(30),
          child: Padding(
            padding: EdgeInsets.all(12.0),
            child: Column(
              children: [
                SourceIcon(source: source),
                Container(height: 8.0),
                Text(
                  source,
                  style: GoogleFonts.kanit(fontSize: 12.0),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSources() => Section(
      title: 'แหล่งข่าว',
      hasSeeMore: false,
      margin: EdgeInsets.only(top: 8.0, bottom: 12.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Padding(
              padding: EdgeInsets.only(left: 8.0),
              child: Row(children: NewsSource.values.map(_buildSource).toList()),
            ),
          ),
        ],
      ));

  Widget _buildCategory(String category) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[100]),
        borderRadius: BorderRadius.all(Radius.circular(12.0)),
      ),
      width: 100.0,
      height: 56.0,
      margin: EdgeInsets.symmetric(horizontal: 4.0),
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
          borderRadius: BorderRadius.all(Radius.circular(12.0)),
          onTap: () => _goToQueryCategoryPage(category),
          splashColor: Colors.blue.withAlpha(30),
          child: Padding(
            padding: EdgeInsets.all(12.0),
            child: Column(
              children: [
                // SourceIcon(source: source),
                // Container(height: 8.0),
                Text(
                  category,
                  style: GoogleFonts.kanit(fontSize: 12.0),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCategories() => Section(
      title: 'ประเภทข่าว',
      hasSeeMore: false,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Padding(
              padding: EdgeInsets.only(left: 8.0),
              child: Row(children: Category.values.map(_buildCategory).toList()),
            ),
          ),
        ],
      ));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        backgroundColor: Colors.white,
        title: Text(ExplorePage.title,
            style: GoogleFonts.kanit(
              color: Colors.black87,
              fontWeight: FontWeight.w500,
              fontSize: 24.0,
            )),
        actions: [
          IconButton(icon: Icon(Icons.search, color: Colors.black87), onPressed: () => _onClickSearch(context)),
        ],
      ),
      backgroundColor: Colors.grey[100],
      body: BlocBuilder<ExploreBloc, ExploreState>(
        builder: (context, state) {
          if (state is ExploreInitial || state is ExploreLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is ExploreLoaded) {
            if (state.trending.topics.isEmpty) {
              return Center(
                child: Text('no feeds'),
              );
            }
            return SmartRefresher(
              enablePullDown: true,
              enablePullUp: state.hasMore,
              header: WaterDropMaterialHeader(),
              physics: BouncingScrollPhysics(),
              controller: _refreshController,
              onRefresh: _onRefresh,
              child: ListView(
                shrinkWrap: true,
                controller: _scrollController,
                children: [
                  _buildSources(),
                  _buildCategories(),
                  _buildTags(state.trending.topics),
                  ImplicitlyAnimatedList<TrendingTopic>(
                    primary: false,
                    shrinkWrap: true,
                    items: state.trending.trendingTopics,
                    physics: const BouncingScrollPhysics(),
                    removeDuration: const Duration(milliseconds: 200),
                    insertDuration: const Duration(milliseconds: 200),
                    updateDuration: const Duration(milliseconds: 200),
                    areItemsTheSame: (a, b) => a == b,
                    itemBuilder: (context, animation, result, i) {
                      return SizeFadeTransition(
                        animation: animation,
                        child: _buildItem(trendingTopic: result, i: i),
                      );
                    },
                    updateItemBuilder: (context, animation, result) {
                      return FadeTransition(
                        opacity: animation,
                        child: _buildItem(trendingTopic: result),
                      );
                    },
                    removeItemBuilder: (context, animation, result) {
                      return FadeTransition(
                        opacity: animation,
                        child: _buildItem(trendingTopic: result),
                      );
                    },
                  )
                ],
              ),
            );
          } else if (state is ExploreError) {
            return RetryError(callback: _onRefresh);
          }
        },
      ),
    );
  }
}
