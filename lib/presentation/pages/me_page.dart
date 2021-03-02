import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spent/presentation/AppRouter.gr.dart';
import 'package:spent/presentation/bloc/authentication/authentication_bloc.dart';
import 'package:spent/presentation/pages/bookmark_page.dart';
import 'package:spent/presentation/pages/history_page.dart';
import 'package:spent/presentation/widgets/list_item.dart';
import 'package:spent/presentation/widgets/nav_drawer_account_header.dart';

class MePage extends StatefulWidget {
  static String title = 'Me';

  MePage({Key key}) : super(key: key);

  @override
  _MePageState createState() => _MePageState();
}

class _MePageState extends State<MePage> {
  static EdgeInsets get _listPadding {
    return EdgeInsets.symmetric(horizontal: 18.0);
  }

  void _handleItemClick(BuildContext context, String route) {
    ExtendedNavigator.of(context).push(route);
  }

  void _handleSignout(BuildContext context) {
    BlocProvider.of<AuthenticationBloc>(context).add(UserSignedOut());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocListener<AuthenticationBloc, AuthenticationState>(
        listener: (context, state) {},
        child: Container(
          color: Colors.white,
          child: ListView(
            children: <Widget>[
              NavDrawerAccountHeader(),
              ListItem(
                title: Text(BookmarkPage.title),
                leading: Icon(Icons.bookmark),
                onTap: () => _handleItemClick(context, Routes.bookmarkPage),
              ),
              ListItem(
                title: Text(HistoryPage.title),
                leading: Icon(Icons.history),
                onTap: () => _handleItemClick(context, Routes.historyPage),
              ),
              Padding(
                padding: _listPadding,
                child: Divider(),
              ),
              ListItem(
                leading: Icon(Icons.settings),
                title: Text('การตั้งค่า'),
                onTap: () => {_handleItemClick(context, Routes.settingPage)},
              ),
              ListItem(
                leading: Icon(Icons.info_outline),
                title: Text('เกี่ยวกับ'),
                onTap: () => {_handleItemClick(context, Routes.aboutPage)},
              ),
              ListItem(
                leading: Icon(Icons.exit_to_app),
                title: Text('ออกจากระบบ'),
                onTap: () => {_handleSignout(context)},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
