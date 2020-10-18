import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:spent/bloc/navigation/navigation_bloc.dart';
import 'package:spent/bloc/search/search_bloc.dart';
import 'package:spent/ui/pages/following_page.dart';

import 'dart:math';

// Page
import 'package:spent/ui/pages/home_page.dart';
import 'package:spent/ui/pages/search_page.dart';
import 'package:spent/ui/place.dart';
import 'package:spent/ui/search_model.dart';
import 'package:spent/ui/widgets/bottom_navbar.dart';
import 'package:spent/ui/widgets/nav_drawer.dart';
import 'package:provider/provider.dart';

import 'package:implicitly_animated_reorderable_list/implicitly_animated_reorderable_list.dart';
import 'package:implicitly_animated_reorderable_list/transitions.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
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
              // appBar: AppBar(
              //   title: Text(
              //     PageName[state.selectedPage],
              //     style: GoogleFonts.kanit(),
              //   ),
              // ),
              resizeToAvoidBottomInset: false,
              body: Stack(
                fit: StackFit.expand,
                children: [_getBody(state), SearchBar()],
              ),
              bottomNavigationBar: BottomNavbar()),
        ));
  }
}

// class SomeScrollableContent extends StatelessWidget {
//   const SomeScrollableContent({Key key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return FloatingSearchBarScrollNotifier(
//       child: ListView.separated(
//         padding: const EdgeInsets.only(top: kToolbarHeight),
//         itemCount: 100,
//         separatorBuilder: (context, index) => const Divider(),
//         itemBuilder: (context, index) {
//           return ListTile(
//             title: Text('Item $index'),
//           );
//         },
//       ),
//     );
//   }
// }

// class FloatingSearchAppBarExample extends StatelessWidget {
//   const FloatingSearchAppBarExample({Key key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return FloatingSearchAppBar(
//       title: const Text('Title'),
//       transitionDuration: const Duration(milliseconds: 800),
//       color: Colors.greenAccent.shade100,
//       colorOnScroll: Colors.greenAccent.shade200,
//       body: ListView.separated(
//         padding: EdgeInsets.zero,
//         itemCount: 100,
//         separatorBuilder: (context, index) => const Divider(),
//         itemBuilder: (context, index) {
//           return ListTile(
//             title: Text('Item $index'),
//           );
//         },
//       ),
//     );
//   }
// }
