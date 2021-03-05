import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:spent/presentation/widgets/list_item.dart';
import 'package:spent/presentation/bloc/navigation/navigation_bloc.dart';

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

  Widget _buildTitle(String title) => Padding(
        padding: const EdgeInsets.only(top: 16.0, bottom: 8.0, left: 18.0),
        child: Text(title, style: GoogleFonts.kanit(fontSize: 15.0, color: Colors.grey[700])),
      );

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
            _buildTitle('ทั่วไป'),
            ListItem(
              leading: Icon(Icons.notifications_outlined),
              title: Text('การแจ้งเตือน'),
              onTap: () => {},
            ),
            ListItem(
              leading: Icon(Icons.text_fields_sharp),
              title: Text('ขนาดตัวอักษร'),
              onTap: () => {},
            ),
            // ListItem(
            //   leading: Icon(Icons.remove_circle_outline),
            //   title: Text(SettingBlockPage.title),
            //   onTap: () => _handleItemClick(context, Routes.settingBlockPage),
            // ),
            Padding(
              padding: _listPadding,
              child: Divider(),
            ),
            _buildTitle('กฏหมายและนโยบาย'),
            ListItem(
              leading: Icon(Icons.assignment_turned_in_outlined),
              title: Text('ข้อกำหนดและเงื่อนไขบริการ'),
              onTap: () => {},
            ),
            ListItem(
              leading: Icon(Icons.verified_user_outlined),
              title: Text('นโยบายคุ้มครองความเป็นส่วนตัว'),
              onTap: () => {},
            ),
            Padding(
              padding: _listPadding,
              child: Divider(),
            ),
            _buildTitle('อื่นๆ'),
            ListItem(
              leading: Icon(Icons.delete_outlined),
              title: Text('ล้างข้อมูลที่บันทึกไว้'),
              onTap: () => {},
            ),
            ListItem(
              leading: Icon(Icons.exit_to_app),
              title: Text('ออกจากระบบ'),
              onTap: () => {},
            )
          ],
        ),
      ),
    );
  }
}
