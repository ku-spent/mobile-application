import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:smart_select/smart_select.dart';
import 'package:spent/domain/model/ModelProvider.dart';
import 'package:spent/presentation/bloc/authentication/authentication_bloc.dart';

import 'package:spent/presentation/widgets/list_item.dart';
import 'package:spent/presentation/widgets/setting_font_size.dart';

class SettingPage extends StatefulWidget {
  static final String title = "ตั้งค่า";

  SettingPage({Key key}) : super(key: key);

  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  void _handleItemClick(BuildContext context, String route) {
    ExtendedNavigator.of(context).push(route);
  }

  void _showConfirmSignOut() {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text("ยกเลิก"),
      onPressed: () {
        ExtendedNavigator.of(context).pop();
      },
    );
    Widget continueButton = TextButton(
      child: Text("ออกจากระบบ"),
      onPressed: () {
        _handleSignout();
        ExtendedNavigator.of(context).pop();
      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("ออกจากระบบ"),
      insetPadding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 24.0),
      content: Text("คุณต้องการที่จะออกจากระบบหรือไม่"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  void _showConfirmClearData() {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text("ยกเลิก"),
      onPressed: () {
        ExtendedNavigator.of(context).pop();
      },
    );
    Widget continueButton = TextButton(
      child: Text("ล้างข้อมูล"),
      onPressed: () {
        _handleClearData();
        ExtendedNavigator.of(context).pop();
      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("ล้างข้อมูล"),
      content: Text("คุณต้องการที่จะลบข้อมูลแคชหรือไม่"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  void _handleSignout() {
    BlocProvider.of<AuthenticationBloc>(context).add(UserSignedOut());
    BotToast.showText(
      text: 'ออกจากระบบ',
      textStyle: GoogleFonts.kanit(color: Colors.white),
    );
  }

  void _handleClearData() async {
    (await Hive.openBox<News>(News.boxName)).deleteFromDisk().then((value) => BotToast.showText(
          text: 'ล้างข้อมูลเสร็จสิ้น',
          textStyle: GoogleFonts.kanit(color: Colors.white),
        ));
  }

  Widget _buildSection({@required String title, @required List<dynamic> children}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
            Container(
              padding: const EdgeInsets.only(top: 16.0, bottom: 8.0, left: 18.0),
              child: Text(title, style: GoogleFonts.kanit(fontSize: 15.0, color: Colors.grey[700])),
            ),
          ] +
          children.map((e) => Container(child: e)).toList() +
          [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 18.0),
              child: Divider(),
            ),
          ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.grey),
        title: Text(SettingPage.title,
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
            _buildSection(
              title: 'ทั่วไป',
              children: [
                // ListItem(
                //   leading: Icon(Icons.notifications_outlined),
                //   title: Text('การแจ้งเตือน'),
                //   onTap: () => {},
                // ),
                SmartSelect<String>.single(
                  title: "การแจ้งเตือน",
                  tileBuilder: (context, state) {
                    return S2Tile.fromState(
                      state,
                      leading: Icon(Icons.notifications_outlined),
                    );
                  },
                  value: "เปิด",
                  onChange: (selected) => {},
                  choiceItems: [
                    S2Choice<String>(value: 'เปิด', title: "เปิด"),
                    S2Choice<String>(value: 'ปิด', title: "ปิด"),
                  ],
                  choiceConfig: S2ChoiceConfig(style: S2ChoiceStyle(titleStyle: GoogleFonts.kanit())),
                  modalConfig: S2ModalConfig(),
                  modalType: S2ModalType.popupDialog,
                  modalHeader: false,
                ),
                SmartSelect<String>.single(
                  title: "ขนาดตัวอักษร",
                  tileBuilder: (context, state) {
                    return S2Tile.fromState(
                      state,
                      leading: Icon(Icons.text_fields_sharp),
                    );
                  },
                  value: "default",
                  onChange: (selected) => {},
                  choiceItems: [
                    S2Choice<String>(value: FontSize.defaultSize, title: "ปกติ"),
                    S2Choice<String>(value: FontSize.largeSize, title: "ใหญ่"),
                  ],
                  choiceConfig: S2ChoiceConfig(style: S2ChoiceStyle(titleStyle: GoogleFonts.kanit())),
                  modalConfig: S2ModalConfig(),
                  modalType: S2ModalType.popupDialog,
                  modalHeader: false,
                )
              ],
            ),
            _buildSection(
              title: 'กฏหมายและนโยบาย',
              children: [
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
              ],
            ),
            _buildSection(
              title: 'อื่นๆ',
              children: [
                ListItem(
                  leading: Icon(Icons.delete_outlined),
                  title: Text('ล้างข้อมูลแคช'),
                  onTap: _showConfirmClearData,
                ),
                ListItem(
                  leading: Icon(Icons.exit_to_app),
                  title: Text('ออกจากระบบ'),
                  onTap: _showConfirmSignOut,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
