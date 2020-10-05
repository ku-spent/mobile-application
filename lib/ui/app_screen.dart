import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spent/bloc/navigation/navigation_bloc.dart';
import 'package:spent/ui/pages/following_page.dart';

// Page
import 'package:spent/ui/pages/home_page.dart';
import 'package:spent/ui/pages/search_page.dart';

class AppScreen extends StatelessWidget {
  const AppScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: BlocProvider(
            create: (BuildContext context) => NavigationBloc(),
            child: BlocBuilder<NavigationBloc, NavigationState>(
                builder: (BuildContext context, NavigationState state) {
              if (state.selectedPage == NavItem.page_home)
                return HomePage();
              else if (state.selectedPage == NavItem.page_search)
                return SearchPage();
              else if (state.selectedPage == NavItem.page_following)
                return FollowingPage();
              else
                return HomePage();
            })));
  }
}
