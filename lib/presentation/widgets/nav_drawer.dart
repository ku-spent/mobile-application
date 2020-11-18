import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spent/presentation/bloc/navigation/navigation_bloc.dart';

class NavDrawer extends StatelessWidget {
  const NavDrawer({Key key}) : super(key: key);

  static EdgeInsets get _listPadding {
    return EdgeInsets.symmetric(horizontal: 18.0);
  }

  @override
  Widget build(BuildContext context) {
    void _handleItemClick(BuildContext context, NavItem item) {
      BlocProvider.of<NavigationBloc>(context).add(NavigateTo(item));
      Navigator.of(context).pop();
    }

    return BlocBuilder<NavigationBloc, NavigationState>(
        builder: (BuildContext context, NavigationState state) => Drawer(
              child: ListView(
                padding: EdgeInsets.only(top: 56.0),
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12.0),
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          'assets/images/icon-logo.svg',
                          semanticsLabel: 'Acme Logo',
                          height: 44,
                          width: 44,
                        ),
                        Container(
                          width: 12,
                        ),
                        Text(
                          'SPENT',
                          style: TextStyle(color: Colors.black87, fontSize: 24),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 32,
                  ),
                  ListTile(
                    title: Text('หน้าแรก'),
                    leading: Icon(Icons.home),
                    selected: state.selectedPage == NavItem.page_home,
                    onTap: () => _handleItemClick(context, NavItem.page_home),
                    contentPadding: _listPadding,
                  ),
                  ListTile(
                    title: Text('การติดตาม'),
                    leading: Icon(Icons.rss_feed_rounded),
                    selected: state.selectedPage == NavItem.page_following,
                    onTap: () => _handleItemClick(context, NavItem.page_following),
                    contentPadding: _listPadding,
                  ),
                  ListTile(
                    title: Text('ที่บันทึกไว้'),
                    leading: Icon(Icons.bookmark),
                    selected: state.selectedPage == NavItem.page_bookmark,
                    onTap: () => {_handleItemClick(context, NavItem.page_bookmark)},
                    contentPadding: _listPadding,
                  ),
                  ListTile(
                    leading: Icon(Icons.history),
                    title: Text('ประวัติการอ่านข่าว'),
                    onTap: () => {Navigator.of(context).pop()},
                    contentPadding: _listPadding,
                  ),
                  Padding(
                    padding: _listPadding,
                    child: Divider(),
                  ),
                  ListTile(
                    leading: Icon(Icons.settings),
                    title: Text('การตั้งค่า'),
                    onTap: () => {Navigator.of(context).pop()},
                    contentPadding: _listPadding,
                  ),
                  ListTile(
                    leading: Icon(Icons.info_outline),
                    title: Text('เกี่ยวกับ'),
                    onTap: () => {Navigator.of(context).pop()},
                    contentPadding: _listPadding,
                  ),
                  ListTile(
                    leading: Icon(Icons.exit_to_app),
                    title: Text('ออกจากระบบ'),
                    onTap: () => {Navigator.of(context).pop()},
                    contentPadding: _listPadding,
                  ),
                ],
              ),
            ));
  }
}
