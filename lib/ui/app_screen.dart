import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:spent/bloc/feed/feed_bloc.dart';
import 'package:spent/bloc/navigation/navigation_bloc.dart';
import 'package:spent/bloc/search/search_bloc.dart';
import 'package:spent/ui/pages/bookmark_page.dart';

// Page
import 'package:spent/ui/pages/following_page.dart';
import 'package:spent/ui/pages/home_page.dart';
import 'package:spent/ui/pages/search_page.dart';
import 'package:spent/ui/widgets/bottom_navbar.dart';

import 'package:spent/ui/widgets/nav_drawer.dart';

class AppScreen extends StatelessWidget {
  const AppScreen({Key key}) : super(key: key);

  Widget _getBody(NavigationState state) {
    switch (state.selectedPage) {
      case NavItem.page_bookmark:
        return BookmarkPage();
      case NavItem.page_following:
        return FollowingPage();
      default:
        return HomePage();
    }
  }

  void _onClickSearch(context) {
    Navigator.push(
        context, CupertinoPageRoute(builder: (context) => SearchPage()));
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<FeedBloc>(create: (BuildContext context) => FeedBloc()),
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
              body: _getBody(state),
              bottomNavigationBar: BottomNavbar()),
        ));
  }
}
