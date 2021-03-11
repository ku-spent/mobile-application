import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:md2_tab_indicator/md2_tab_indicator.dart';

import 'package:spent/domain/model/ModelProvider.dart';
import 'package:spent/presentation/pages/feed_page.dart';
import 'package:spent/presentation/pages/for_you_page.dart';
import 'package:spent/presentation/widgets/card_base.dart';

class HomePage extends StatefulWidget {
  static String title = 'Home';
  final void Function(int) onTabChange;
  final TabController tabController;
  final int tabLength;
  final List<ScrollController> scrollControllerList;

  HomePage(
      {Key key,
      @required this.scrollControllerList,
      @required this.tabController,
      @required this.tabLength,
      @required this.onTabChange})
      : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _tabbarLength;
  TabController _tabController;
  List<ScrollController> _scrollControllerList;

  @override
  void initState() {
    super.initState();
    _tabbarLength = widget.tabLength;
    _tabController = widget.tabController;
    _scrollControllerList = widget.scrollControllerList;
    _tabController.addListener(() {
      print("tab change ${_tabController.index}");
      widget.onTabChange(_tabController.index);
    });
  }

  Widget _buildItem({News news, int i = -1, String recommendationId}) {
    return CardBase(
      news: news,
      isSecondary: i % 4 != 0,
      recommendationId: recommendationId,
    );
  }

  Widget _buildAppbar() {
    return AppBar(
      backgroundColor: Theme.of(context).primaryColor,
      flexibleSpace: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(top: 4.0, right: 24.0, left: 24.0),
          child: TabBar(
            controller: _tabController,
            labelStyle: GoogleFonts.kanit(fontWeight: FontWeight.w500, fontSize: 18.0),
            unselectedLabelStyle: GoogleFonts.kanit(fontSize: 16.0),
            indicatorSize: TabBarIndicatorSize.tab,
            labelColor: Colors.white,
            // isScrollable: true,
            indicator: MD2Indicator(
              indicatorHeight: 3,
              indicatorSize: MD2IndicatorSize.full,
              indicatorColor: Colors.white,
            ),
            tabs: <Widget>[
              Tab(text: "สำหรับคุณ"),
              Tab(text: "ล่าสุด"),
              // Tab(text: Category.politics),
              // Tab(text: Category.economic),
              // Tab(text: Category.sport),
              // Tab(text: Category.technology),
              // Tab(text: Category.localNews),
              // Tab(text: Category.movie),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _tabbarLength,
      child: Scaffold(
          // endDrawer: NavDrawer(),
          appBar: _buildAppbar(),
          body: TabBarView(
            controller: _tabController,
            children: <Widget>[
              ForYouPage(scrollController: _scrollControllerList[0], buildRecommendationItem: _buildItem),
              FeedPage(scrollController: _scrollControllerList[1], buildFeedItem: _buildItem),
              // Center(child: Text(Category.politics)),
              // Center(child: Text(Category.economic)),
              // Center(child: Text(Category.sport)),
              // Center(child: Text(Category.technology)),
              // Center(child: Text(Category.localNews)),
              // Center(child: Text(Category.movie)),
            ],
          )),
    );
  }
}
