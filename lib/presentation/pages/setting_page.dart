import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:spent/presentation/AppRouter.gr.dart';
import 'package:spent/presentation/bloc/navigation/navigation_bloc.dart';
import 'package:spent/presentation/pages/setting_block_page.dart';

class SettingPage extends StatefulWidget {
  SettingPage({Key key}) : super(key: key);

  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  static EdgeInsets get _listPadding {
    return EdgeInsets.symmetric(horizontal: 18.0);
  }

  static EdgeInsets get _dividerPadding {
    return EdgeInsets.only(bottom: 12.0);
  }

  void _handleItemClick(BuildContext context, String route) {
    ExtendedNavigator.of(context).push(route);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.grey),
        title: Text(PageName[NavItem.page_setting],
            style: GoogleFonts.kanit(
              color: Colors.black87,
              // fontSize: 24.0,
            )),
        backgroundColor: Colors.white,
        elevation: 1,
      ),
      body: Container(
        color: Colors.white,
        child: ListView(
          children: <Widget>[
            ListTile(
              title: Text(SettingBlockPage.title),
              onTap: () => _handleItemClick(context, Routes.settingBlockPage),
              contentPadding: _listPadding,
            ),
          ],
        ),
      ),
    );
  }
}
