import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:spent/presentation/bloc/navigation/navigation_bloc.dart';

class AboutPage extends StatefulWidget {
  AboutPage({Key key}) : super(key: key);

  @override
  _AboutPageState createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text(
          PageName[NavItem.page_about],
          style: GoogleFonts.kanit(),
        )),
        body: Center(
          child: Text('About'),
        ));
  }
}
