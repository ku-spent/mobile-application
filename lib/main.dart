import 'package:flutter/material.dart';
import 'package:spent/ui/pages/splash_screen.dart';
import 'package:spent/ui/theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'SPENT',
        theme: MyTheme(context: context).mainTheme,
        home: SplashPage());
  }
}
