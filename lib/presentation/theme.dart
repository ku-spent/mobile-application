import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Map<int, Color> mainColor = {
  50: Color.fromRGBO(0, 131, 255, .1),
  100: Color.fromRGBO(0, 131, 255, .2),
  200: Color.fromRGBO(0, 131, 255, .3),
  300: Color.fromRGBO(0, 131, 255, .4),
  400: Color.fromRGBO(0, 131, 255, .5),
  500: Color.fromRGBO(0, 131, 255, .6),
  600: Color.fromRGBO(0, 131, 255, .7),
  700: Color.fromRGBO(0, 131, 255, .8),
  800: Color.fromRGBO(0, 131, 255, .9),
  900: Color.fromRGBO(0, 131, 255, 1),
};

class MyTheme {
  BuildContext context;
  MyTheme({this.context});

  static MaterialColor get _mainColor => MaterialColor(mainColor[900].value, mainColor);

  ThemeData get mainTheme => ThemeData(
        primarySwatch: _mainColor,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        textTheme: GoogleFonts.kanitTextTheme(Theme.of(context).textTheme),
        // textButtonTheme: TextButtonThemeData(style: GoogleFonts.kanitTextTheme()),
      );
}
