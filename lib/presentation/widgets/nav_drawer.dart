import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spent/presentation/AppRouter.gr.dart';
import 'package:spent/presentation/bloc/navigation/navigation_bloc.dart';
import 'package:spent/presentation/widgets/nav_drawer_account_header.dart';

class NavDrawer extends StatelessWidget {
  const NavDrawer({Key key}) : super(key: key);

  static EdgeInsets get _listPadding {
    return EdgeInsets.symmetric(horizontal: 18.0);
  }

  @override
  Widget build(BuildContext context) {
    void _handleHomeItemClick(BuildContext context, NavItem item) {
      BlocProvider.of<NavigationBloc>(context).add(NavigateTo(item));
      Navigator.of(context).pop();
    }

    void _handleItemClick(BuildContext context, String route) {
      ExtendedNavigator.of(context).push(route);
      Navigator.of(context).pop();
    }

    void _handleSignout(BuildContext context) {
      BlocProvider.of<NavigationBloc>(context).add(NavigateSignout());
      Navigator.of(context).pop();
    }

    return BlocBuilder<NavigationBloc, NavigationState>(
      builder: (BuildContext context, NavigationState state) => Drawer(
        child: Container(
          color: Colors.white,
          child: ListView(
            // padding: EdgeInsets.only(top: 56.0),
            children: <Widget>[
              NavDrawerAccountHeader(),
              // Padding(
              //   padding: EdgeInsets.symmetric(horizontal: 12.0),
              //   child: Row(
              //     children: [
              //       SvgPicture.asset(
              //         'assets/images/icon-logo.svg',
              //         semanticsLabel: 'Acme Logo',
              //         height: 44,
              //         width: 44,
              //       ),
              //       Container(
              //         width: 12,
              //       ),
              //       Text(
              //         'SPENT',
              //         style: TextStyle(color: Colors.black87, fontSize: 24),
              //       ),
              //     ],
              //   ),
              // ),
              // Container(
              //   height: 32,
              // ),
              ListTile(
                title: Text(PageName[NavItem.page_home]),
                leading: Icon(Icons.home),
                selected: state.selectedPage == NavItem.page_home,
                onTap: () => _handleHomeItemClick(context, NavItem.page_home),
                contentPadding: _listPadding,
              ),
              ListTile(
                title: Text(PageName[NavItem.page_following]),
                leading: Icon(Icons.rss_feed_rounded),
                selected: state.selectedPage == NavItem.page_following,
                onTap: () => _handleHomeItemClick(context, NavItem.page_following),
                contentPadding: _listPadding,
              ),
              ListTile(
                title: Text(PageName[NavItem.page_bookmark]),
                leading: Icon(Icons.bookmark),
                selected: state.selectedPage == NavItem.page_bookmark,
                onTap: () => _handleHomeItemClick(context, NavItem.page_bookmark),
                contentPadding: _listPadding,
              ),
              ListTile(
                title: Text(PageName[NavItem.page_history]),
                leading: Icon(Icons.history),
                selected: state.selectedPage == NavItem.page_history,
                onTap: () => _handleItemClick(context, Routes.historyPage),
                contentPadding: _listPadding,
              ),
              Padding(
                padding: _listPadding,
                child: Divider(),
              ),
              ListTile(
                leading: Icon(Icons.settings),
                title: Text('การตั้งค่า'),
                onTap: () => {_handleItemClick(context, Routes.settingPage)},
                contentPadding: _listPadding,
              ),
              ListTile(
                leading: Icon(Icons.info_outline),
                title: Text('เกี่ยวกับ'),
                onTap: () => {_handleItemClick(context, Routes.aboutPage)},
                contentPadding: _listPadding,
              ),
              ListTile(
                leading: Icon(Icons.exit_to_app),
                title: Text('ออกจากระบบ'),
                onTap: () => {_handleSignout(context)},
                contentPadding: _listPadding,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
