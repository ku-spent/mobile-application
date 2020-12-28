import 'dart:io';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:spent/di/di.dart';
import 'package:spent/presentation/AppRouter.gr.dart';
import 'package:spent/presentation/bloc/navigation/navigation_bloc.dart';
import 'package:spent/presentation/pages/bookmark_page.dart';

// Page
import 'package:spent/presentation/pages/following_page.dart';
import 'package:spent/presentation/pages/home_page.dart';

import 'package:spent/presentation/widgets/bottom_navbar.dart';
import 'package:spent/presentation/widgets/keep_alive_page.dart';
import 'package:spent/presentation/widgets/nav_drawer.dart';

class AppScreen extends StatefulWidget {
  AppScreen({Key key}) : super(key: key);

  @override
  _AppScreenState createState() => _AppScreenState();
}

class _AppScreenState extends State<AppScreen> {
  final _channel = const MethodChannel('com.example.spent/app_retain');
  final ScrollController _homeScrollController = ScrollController();
  final ScrollController _followingScrollController = ScrollController();
  final ScrollController _bookmarkScrollController = ScrollController();
  ScrollController _currentScrollController;

  final PageController _pageController = PageController(
    initialPage: 0,
    keepPage: true,
  );

  @override
  void initState() {
    _currentScrollController = _homeScrollController;
    super.initState();
  }

  void _onPageChanged(BuildContext context, int index) {
    if (_pageController.page == 0.0) {
      _currentScrollController = _homeScrollController;
    } else if (_pageController.page == 1.0) {
      _currentScrollController = _followingScrollController;
    } else if (_pageController.page == 2.0) {
      _currentScrollController = _bookmarkScrollController;
    } else {
      _currentScrollController = _homeScrollController;
    }
    NavItem item = NavItem.values[index];
    BlocProvider.of<NavigationBloc>(context).add(NavigateTo(item));
  }

  void _onClickSearch(context) {
    ExtendedNavigator.of(context).push(Routes.searchPage);
  }

  Future<bool> onWillPop(BuildContext context) async {
    try {
      final _pageController = BlocProvider.of<NavigationBloc>(context).pageController;
      if (_pageController.page.round() == _pageController.initialPage) {
        if (Platform.isAndroid) {
          print('pop');
          if (Navigator.of(context).canPop()) {
            return true;
          } else {
            _channel.invokeMethod('sendToBackground');
            return false;
          }
        } else {
          return true;
        }
      } else {
        _onPageChanged(context, 0);
        return false;
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<NavigationBloc>(
      create: (BuildContext context) => getIt<NavigationBloc>(param1: _pageController),
      child: BlocBuilder<NavigationBloc, NavigationState>(
        builder: (BuildContext context, NavigationState state) => WillPopScope(
          onWillPop: () => onWillPop(context),
          child: Scaffold(
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
                KeepAlivePage(child: HomePage(scrollController: _homeScrollController)),
                KeepAlivePage(child: FollowingPage(scrollController: _followingScrollController)),
                KeepAlivePage(child: BookmarkPage(scrollController: _bookmarkScrollController)),
              ],
            ),
            bottomNavigationBar: BottomNavbar(scrollController: _currentScrollController),
          ),
        ),
      ),
    );
  }
}
