import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

import 'package:spent/di/di.dart';
import 'package:spent/presentation/bloc/navigation/navigation_bloc.dart';
import 'package:spent/presentation/pages/me_page.dart';
import 'package:spent/presentation/pages/notification_page.dart';
import 'package:spent/presentation/pages/explore_page.dart';

// Page
import 'package:spent/presentation/pages/home_page.dart';
import 'package:spent/presentation/widgets/app_retain_widget.dart';

class AppScreen extends StatefulWidget {
  AppScreen({Key key}) : super(key: key);

  @override
  _AppScreenState createState() => _AppScreenState();
}

class _AppScreenState extends State<AppScreen> with SingleTickerProviderStateMixin {
  final _channel = const MethodChannel('com.example.spent/app_retain');
  final int _tabbarLength = 2;
  final ScrollController _explorePageScrollController = ScrollController();
  int _curTabIndex = 0;
  List<ScrollController> _tabScrollControllerList;
  PersistentTabController _controller;
  TabController _tabController;

  final PageController _pageController = PageController(
    initialPage: 0,
    keepPage: true,
  );

  @override
  void initState() {
    assert(_tabbarLength > 0);
    _controller = PersistentTabController(initialIndex: 0);
    _tabController = TabController(vsync: this, length: _tabbarLength);
    _tabScrollControllerList = List.generate(_tabbarLength, (_) => ScrollController());
    super.initState();
  }

  void _setCurTabIndex(int index) {
    setState(() {
      _curTabIndex = index;
    });
  }

  void _scrollPageToTop(ScrollController scrollController, int index) {
    if (_controller.index == index)
      scrollController.animateTo(scrollController.position.minScrollExtent,
          duration: Duration(milliseconds: 300), curve: Curves.easeOutExpo);
    else {
      _controller.jumpToTab(index);
    }
  }

  void _scrollHomePageToTop() {
    _scrollPageToTop(_tabScrollControllerList[_curTabIndex], 0);
  }

  void _scrollExplorePageToTop() {
    _scrollPageToTop(_explorePageScrollController, 1);
  }

  Future<bool> _onWillPop() async {
    if (_tabController.index != 0) {
      _tabController.animateTo(0);
      return false;
    } else if (_tabScrollControllerList[0].offset != 0.0) {
      _scrollHomePageToTop();
      return false;
    } else {
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
    }
  }

  List<Widget> _buildScreens() {
    return [
      HomePage(
        scrollControllerList: _tabScrollControllerList,
        tabController: _tabController,
        tabLength: _tabbarLength,
        onTabChange: _setCurTabIndex,
      ),
      AppRetainWidget(child: ExplorePage(scrollController: _explorePageScrollController)),
      AppRetainWidget(child: NotificationPage()),
      AppRetainWidget(child: MePage()),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: Icon(Icons.home),
        title: HomePage.title,
        inactiveColor: Colors.grey,
        activeColorAlternate: Theme.of(context).primaryColor,
        textStyle: GoogleFonts.kanit(fontSize: 12.0),
        activeColor: Theme.of(context).primaryColorLight,
        onPressed: _scrollHomePageToTop,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.explore),
        title: ExplorePage.title,
        inactiveColor: Colors.grey,
        activeColorAlternate: Theme.of(context).primaryColor,
        textStyle: GoogleFonts.kanit(fontSize: 12.0),
        activeColor: Theme.of(context).primaryColorLight,
        onPressed: _scrollExplorePageToTop,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.notifications),
        title: "Notifications",
        inactiveColor: Colors.grey,
        activeColorAlternate: Theme.of(context).primaryColor,
        textStyle: GoogleFonts.kanit(fontSize: 12.0),
        activeColor: Theme.of(context).primaryColorLight,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.account_circle),
        title: "Me",
        inactiveColor: Colors.grey,
        activeColorAlternate: Theme.of(context).primaryColor,
        textStyle: GoogleFonts.kanit(fontSize: 12.0),
        activeColor: Theme.of(context).primaryColorLight,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<NavigationBloc>(
      create: (BuildContext context) => getIt<NavigationBloc>(param1: _pageController),
      child: BlocBuilder<NavigationBloc, NavigationState>(
        builder: (BuildContext context, NavigationState state) => PersistentTabView(
          context,
          decoration: NavBarDecoration(boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 2.0)]),
          controller: _controller,
          screens: _buildScreens(),
          items: _navBarsItems(),
          confineInSafeArea: true,
          backgroundColor: Colors.white,
          handleAndroidBackButtonPress: true,
          resizeToAvoidBottomInset: true,
          stateManagement: true,
          navBarHeight: MediaQuery.of(context).viewInsets.bottom > 0 ? 0.0 : kBottomNavigationBarHeight,
          hideNavigationBarWhenKeyboardShows: true,
          popActionScreens: PopActionScreensType.all,
          onWillPop: _onWillPop,
          popAllScreensOnTapOfSelectedTab: true,
          itemAnimationProperties: ItemAnimationProperties(
            duration: Duration(milliseconds: 400),
            curve: Curves.ease,
          ),
          screenTransitionAnimation: ScreenTransitionAnimation(
            animateTabTransition: true,
            curve: Curves.ease,
            duration: Duration(milliseconds: 200),
          ),
          navBarStyle: NavBarStyle.style7, // Choose the nav bar style with this property
        ),
      ),
    );
  }
}
