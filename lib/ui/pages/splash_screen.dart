import 'package:flutter/material.dart';
import 'package:spent/ui/app_screen.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SplashScreen(
        seconds: 1,
        navigateAfterSeconds: AppScreen(),
        title: Text(
          'SPENT',
          style: GoogleFonts.kanit(),
        ),
        image: Image.asset('assets/images/logo.png'),
        backgroundColor: Colors.white,
        styleTextUnderTheLoader: TextStyle(color: Colors.deepPurple),
        photoSize: 100.0,
        loaderColor: Theme.of(context).primaryColor);
  }
}
