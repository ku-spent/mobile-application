import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:spent/bloc/navigation/navigation_bloc.dart';
import 'package:spent/ui/pages/bookmark_page.dart';

// Page
import 'package:spent/ui/pages/following_page.dart';
import 'package:spent/ui/pages/home_page.dart';
import 'package:spent/ui/pages/search_page.dart';

import 'package:spent/ui/widgets/bottom_navbar.dart';
import 'package:spent/ui/widgets/nav_drawer.dart';

class AppScreen extends StatelessWidget {
  final ScrollController _scrollController = ScrollController();
  final PageController pageController;

  AppScreen({Key key, @required this.pageController}) : super(key: key);

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
    return BlocBuilder<NavigationBloc, NavigationState>(
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
            controller: pageController,
            onPageChanged: (int index) => _onPageChanged(context, index),
            children: [
              HomePage(
                scrollController: _scrollController,
              ),
              FollowingPage(),
              BookmarkPage()
            ],
          ),
          bottomNavigationBar: BottomNavbar(
            scrollController: _scrollController,
          )),
    );
  }
}
