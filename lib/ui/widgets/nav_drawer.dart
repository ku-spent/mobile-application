import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spent/bloc/navigation/navigation_bloc.dart';

class NavDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    void _handleItemClick(BuildContext context, NavItem item) {
      BlocProvider.of<NavigationBloc>(context).add(NavigateTo(item));
      Navigator.of(context).pop();
    }

    return BlocBuilder<NavigationBloc, NavigationState>(
        builder: (BuildContext context, NavigationState state) => Drawer(
              child: ListView(
                padding: EdgeInsets.only(top: 56.0, left: 18.0, right: 18.0),
                children: <Widget>[
                  Row(
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
                  Container(
                    height: 32,
                  ),
                  ListTile(
                    leading: Icon(Icons.home),
                    selected: state.selectedPage == NavItem.page_home,
                    title: Text('หน้าแรก'),
                    onTap: () => _handleItemClick(context, NavItem.page_home),
                  ),
                  ListTile(
                    leading: Icon(Icons.search),
                    selected: state.selectedPage == NavItem.page_search,
                    title: Text('ค้นหา'),
                    onTap: () => _handleItemClick(context, NavItem.page_search),
                  ),
                  ListTile(
                    leading: Icon(Icons.rss_feed_rounded),
                    selected: state.selectedPage == NavItem.page_following,
                    title: Text('การติดตาม'),
                    onTap: () =>
                        _handleItemClick(context, NavItem.page_following),
                  ),
                  ListTile(
                    leading: Icon(Icons.bookmark),
                    title: Text('คั่นหน้า'),
                    onTap: () => {Navigator.of(context).pop()},
                  ),
                  ListTile(
                    leading: Icon(Icons.history),
                    title: Text('ประวัติการอ่านข่าว'),
                    onTap: () => {Navigator.of(context).pop()},
                  ),
                  Divider(),
                  ListTile(
                    leading: Icon(Icons.settings),
                    title: Text('การตั้งค่า'),
                    onTap: () => {Navigator.of(context).pop()},
                  ),
                  ListTile(
                    leading: Icon(Icons.info_outline),
                    title: Text('เกี่ยวกับ'),
                    onTap: () => {Navigator.of(context).pop()},
                  ),
                  ListTile(
                    leading: Icon(Icons.exit_to_app),
                    title: Text('ออกจากระบบ'),
                    onTap: () => {Navigator.of(context).pop()},
                  ),
                ],
              ),
            ));
  }
}
