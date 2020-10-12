import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:spent/bloc/navigation/navigation_bloc.dart';
import 'package:spent/ui/pages/following_page.dart';

// Page
import 'package:spent/ui/pages/home_page.dart';
import 'package:spent/ui/pages/search_page.dart';
import 'package:spent/ui/widgets/nav_drawer.dart';

class AppScreen extends StatelessWidget {
  const AppScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget _getBody(NavigationState state) {
      switch (state.selectedPage) {
        case NavItem.page_search:
          return SearchPage();
        case NavItem.page_following:
          return FollowingPage();
        default:
          return HomePage();
      }
    }

    return Container(
        child: BlocProvider(
            create: (BuildContext context) => NavigationBloc(),
            child: BlocBuilder<NavigationBloc, NavigationState>(
                builder: (BuildContext context, NavigationState state) {
              return Scaffold(
                  drawer: NavDrawer(),
                  appBar: AppBar(
                    title: Text(
                      PageName[state.selectedPage],
                      style: GoogleFonts.kanit(),
                    ),
                  ),
                  body: _getBody(state));
            })));
  }
}
