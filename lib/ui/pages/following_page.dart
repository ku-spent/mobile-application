import 'package:flutter/material.dart';
import 'package:spent/ui/widgets/bottom_navbar.dart';

class FollowingPage extends StatefulWidget {
  FollowingPage({Key key}) : super(key: key);

  @override
  _FollowingPageState createState() => _FollowingPageState();
}

class _FollowingPageState extends State<FollowingPage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Following'),
    );
  }
}
