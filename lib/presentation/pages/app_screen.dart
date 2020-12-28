import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:spent/di/di.dart';
import 'package:spent/presentation/bloc/navigation/navigation_bloc.dart';
import 'package:spent/presentation/pages/bookmark_page.dart';

// Page
import 'package:spent/presentation/pages/following_page.dart';
import 'package:spent/presentation/pages/home_page.dart';
import 'package:spent/presentation/pages/search_page.dart';
import 'package:spent/presentation/widgets/app_retain_widget.dart';

import 'package:spent/presentation/widgets/bottom_navbar.dart';
import 'package:spent/presentation/widgets/nav_drawer.dart';

class AppScreen extends StatelessWidget {
  final ScrollController _scrollController = ScrollController();

  final PageController _pageController = PageController(
    initialPage: 0,
  );

  AppScreen({Key key}) : super(key: key);

  void _onPageChanged(BuildContext context, int index) {
    print(index);
    NavItem item = NavItem.values[index];
    BlocProvider.of<NavigationBloc>(context).add(NavigateTo(item));
  }

  void _onClickSearch(context) {
    Navigator.push(context, CupertinoPageRoute(builder: (context) => SearchPage()));
  }

  @override
  Widget build(BuildContext context) {
    return AppRetainWidget(
      child: BlocProvider<NavigationBloc>(
        create: (BuildContext context) => getIt<NavigationBloc>(param1: _pageController),
        child: BlocBuilder<NavigationBloc, NavigationState>(
          builder: (BuildContext context, NavigationState state) => Scaffold(
            drawer: NavDrawer(),
            appBar: AppBar(
              title: Text(
                PageName[state.selectedPage],
                style: GoogleFonts.kanit(),
              ),
              actions: [
                IconButton(icon: Icon(Icons.search), onPressed: () => _onClickSearch(context)),
              ],
            ),
            resizeToAvoidBottomInset: false,
            backgroundColor: Colors.white,
            body: PageView(
              controller: BlocProvider.of<NavigationBloc>(context).pageController,
              onPageChanged: (int index) => _onPageChanged(context, index),
              children: [
                HomePage(scrollController: _scrollController),
                FollowingPage(),
                BookmarkPage(scrollController: _scrollController),
              ],
            ),
            bottomNavigationBar: BottomNavbar(scrollController: _scrollController),
          ),
        ),
      ),
    );
  }
}
