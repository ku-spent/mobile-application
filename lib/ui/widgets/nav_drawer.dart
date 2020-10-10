import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NavDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
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
          Padding(
            padding: EdgeInsets.symmetric(vertical: 24.0, horizontal: 4.0),
            child: Container(
              child: TextField(
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.search),
                ),
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('หน้าแรก'),
            onTap: () => {},
          ),
          ListTile(
            leading: Icon(Icons.rss_feed_rounded),
            title: Text('การติดตาม'),
            onTap: () => {Navigator.of(context).pop()},
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
    );
  }
}
