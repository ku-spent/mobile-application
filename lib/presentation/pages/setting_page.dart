import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:spent/presentation/bloc/navigation/navigation_bloc.dart';

class SettingPage extends StatefulWidget {
  SettingPage({Key key}) : super(key: key);

  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // drawer: NavDrawer(),
      appBar: AppBar(
          title: Text(
        PageName[NavItem.page_setting],
        style: GoogleFonts.kanit(),
      )),
      body: Center(
        child: Text('Setting'),
      ),
    );
  }
}
