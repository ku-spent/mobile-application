import 'package:flutter/material.dart';

class FollowingPage extends StatefulWidget {
  final ScrollController scrollController;

  FollowingPage({Key key, @required this.scrollController}) : super(key: key);

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
