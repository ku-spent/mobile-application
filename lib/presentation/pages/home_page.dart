import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:md2_tab_indicator/md2_tab_indicator.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:spent/domain/model/ModelProvider.dart';
import 'package:spent/domain/model/category.dart';
import 'package:spent/presentation/bloc/feed/feed_bloc.dart';
import 'package:spent/presentation/pages/feed_page.dart';
import 'package:spent/presentation/pages/for_you_page.dart';
import 'package:spent/presentation/widgets/card_base.dart';
import 'package:spent/presentation/widgets/nav_drawer.dart';

class HomePage extends StatefulWidget {
  static String title = 'Home';

  final ScrollController scrollController;
  final TabController tabController;

  HomePage({Key key, @required this.scrollController, @required this.tabController}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ScrollController _scrollController;
  TabController _tabController;

  final _tabbarLength = 8;

  @override
  void initState() {
    super.initState();
    _scrollController = widget.scrollController;
    _tabController = widget.tabController;
  }

  Widget _buildItem({News news, int i = -1}) {
    return CardBase(
      news: news,
      isSecondary: i % 4 != 0,
    );
  }

  Widget _buildAppbar() {
    return AppBar(
      backgroundColor: Theme.of(context).primaryColor,
      flexibleSpace: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(top: 4.0, right: 36.0),
          child: TabBar(
            controller: _tabController,
            labelStyle: GoogleFonts.kanit(fontWeight: FontWeight.w500, fontSize: 18.0),
            unselectedLabelStyle: GoogleFonts.kanit(fontSize: 16.0),
            indicatorSize: TabBarIndicatorSize.label,
            labelColor: Colors.white,
            isScrollable: true,
            indicator: MD2Indicator(
              indicatorHeight: 3,
              indicatorSize: MD2IndicatorSize.full,
              indicatorColor: Colors.white,
            ),
            tabs: <Widget>[
              Tab(text: "สำหรับคุณ"),
              Tab(text: "ล่าสุด"),
              Tab(text: Category.politics),
              Tab(text: Category.economic),
              Tab(text: Category.sport),
              Tab(text: Category.technology),
              Tab(text: Category.localNews),
              Tab(text: Category.movie),
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
          endDrawer: NavDrawer(),
          appBar: _buildAppbar(),
          body: TabBarView(
            controller: _tabController,
            children: <Widget>[
              ForYouPage(scrollController: _scrollController, buildRecommendationItem: _buildItem),
              FeedPage(buildFeedItem: _buildItem),
              Center(child: Text(Category.politics)),
              Center(child: Text(Category.economic)),
              Center(child: Text(Category.sport)),
              Center(child: Text(Category.technology)),
              Center(child: Text(Category.localNews)),
              Center(child: Text(Category.movie)),
            ],
          )),
    );
  }
}

class BottomLoader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Center(
        child: SizedBox(
          width: 33,
          height: 33,
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
