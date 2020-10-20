import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spent/bloc/navigation/navigation_bloc.dart';
import 'package:spent/bloc/search/search_bloc.dart';

// Page
import 'package:spent/ui/pages/following_page.dart';
import 'package:spent/ui/pages/home_page.dart';
import 'package:spent/ui/pages/search_page.dart';
import 'package:spent/ui/widgets/bottom_navbar.dart';

import 'package:spent/ui/widgets/nav_drawer.dart';
import 'package:spent/ui/widgets/search_bar.dart';

class AppScreen extends StatelessWidget {
  const AppScreen({Key key}) : super(key: key);

  Widget _getBody(NavigationState state) {
    switch (state.selectedPage) {
      case NavItem.page_search:
        return SearchPage();
      case NavItem.page_following:
        return FollowingPage();
      default:
        return Container(
          margin: const EdgeInsets.only(top: 76),
          child: HomePage(),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<NavigationBloc>(
              create: (BuildContext context) => NavigationBloc()),
          BlocProvider<SearchBloc>(
              create: (BuildContext context) => SearchBloc())
        ],
        child: BlocBuilder<NavigationBloc, NavigationState>(
          builder: (BuildContext context, NavigationState state) => Scaffold(
              drawer: NavDrawer(),
              resizeToAvoidBottomInset: false,
              body: Stack(
                fit: StackFit.expand,
                children: [
                  _getBody(state),
                  Container(
                    margin: EdgeInsets.only(top: 8),
                    child: SearchBar(),
                  )
                ],
              ),
              bottomNavigationBar: BottomNavbar()),
        ));
  }
}
