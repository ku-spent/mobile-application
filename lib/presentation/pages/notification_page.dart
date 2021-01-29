import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NotificationPage extends StatefulWidget {
  static String title = 'Notification';

  NotificationPage({Key key}) : super(key: key);

  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          NotificationPage.title,
          style: GoogleFonts.kanit(),
        ),
      ),
      backgroundColor: Colors.white,
      body: Center(child: Text('Notification')),
    );
  }
}
