import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:spent/bloc/feed/feed_bloc.dart';
import 'package:spent/bloc/navigation/navigation_bloc.dart';
import 'package:spent/bloc/search/search_bloc.dart';
import 'package:spent/repository/feed_repository.dart';
import 'package:spent/ui/pages/bookmark_page.dart';
import 'package:http/http.dart' as http;

// Page
import 'package:spent/ui/pages/following_page.dart';
import 'package:spent/ui/pages/home_page.dart';
import 'package:spent/ui/pages/search_page.dart';

import 'package:spent/ui/widgets/bottom_navbar.dart';
import 'package:spent/ui/widgets/nav_drawer.dart';

class AppScreen extends StatelessWidget {
  final ScrollController _scrollController = ScrollController();
  final PageController _pageController = PageController(
    initialPage: 0,
  );

  void _onPageChanged(BuildContext context, int index) {
    NavItem item = NavItem.values[index];
    BlocProvider.of<NavigationBloc>(context).add(NavigateTo(item));
  }

  void _onClickSearch(context) {
    Navigator.push(
        context, CupertinoPageRoute(builder: (context) => SearchPage()));
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<FeedBloc>(
              create: (BuildContext context) => FeedBloc(
                  feedRepository: FeedRepository(client: http.Client()))),
          BlocProvider<NavigationBloc>(
              create: (BuildContext context) => NavigationBloc()),
          BlocProvider<SearchBloc>(
              create: (BuildContext context) => SearchBloc())
        ],
        child: BlocBuilder<NavigationBloc, NavigationState>(
          builder: (BuildContext context, NavigationState state) => Scaffold(
              drawer: NavDrawer(),
              appBar: AppBar(
                title: Text(
                  PageName[state.selectedPage],
                  style: GoogleFonts.kanit(),
                ),
                actions: [
                  IconButton(
                      icon: Icon(Icons.search),
                      onPressed: () => _onClickSearch(context))
                ],
              ),
              resizeToAvoidBottomInset: false,
              backgroundColor: Colors.white,
              body: PageView(
                controller: _pageController,
                onPageChanged: (int index) => _onPageChanged(context, index),
                children: [
                  HomePage(
                    scrollController: _scrollController,
                  ),
                  FollowingPage(),
                  BookmarkPage()
                ],
              ),
              // body: _getBody(state),
              bottomNavigationBar: BottomNavbar(
                  scrollController: _scrollController,
                  pageController: _pageController)),
        ));
  }
}
