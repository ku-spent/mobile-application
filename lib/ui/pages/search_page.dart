import 'package:flutter/material.dart';
import 'package:spent/ui/widgets/bottom_navbar.dart';

class SearchPage extends StatefulWidget {
  SearchPage({Key key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text('Search')),
      bottomNavigationBar: BottomNavbar(),
    );
  }
}
