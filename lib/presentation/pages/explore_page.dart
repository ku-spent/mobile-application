import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:spent/presentation/AppRouter.gr.dart';

class ExplorePage extends StatefulWidget {
  static String title = 'Explore';

  ExplorePage({Key key}) : super(key: key);

  @override
  _ExplorePageState createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  void _onClickSearch(context) {
    ExtendedNavigator.of(context).push(Routes.searchPage);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          ExplorePage.title,
          style: GoogleFonts.kanit(),
        ),
        actions: [
          IconButton(icon: Icon(Icons.search), onPressed: () => _onClickSearch(context)),
        ],
      ),
      backgroundColor: Colors.white,
      body: Center(child: Text('Explore')),
    );
  }
}
