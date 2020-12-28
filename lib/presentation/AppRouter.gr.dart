// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs

import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'pages/about_page.dart';
import 'pages/app_screen.dart';
import 'pages/history_page.dart';
import 'pages/setting_page.dart';
import 'pages/splash_page.dart';

class Routes {
  static const String splashPage = '/';
  static const String appScreen = '/home';
  static const String historyPage = '/bookmark';
  static const String settingPage = '/setting';
  static const String aboutPage = '/about';
  static const all = <String>{
    splashPage,
    appScreen,
    historyPage,
    settingPage,
    aboutPage,
  };
}

class AppRouter extends RouterBase {
  @override
  List<RouteDef> get routes => _routes;
  final _routes = <RouteDef>[
    RouteDef(Routes.splashPage, page: SplashPage),
    RouteDef(Routes.appScreen, page: AppScreen),
    RouteDef(Routes.historyPage, page: HistoryPage),
    RouteDef(Routes.settingPage, page: SettingPage),
    RouteDef(Routes.aboutPage, page: AboutPage),
  ];
  @override
  Map<Type, AutoRouteFactory> get pagesMap => _pagesMap;
  final _pagesMap = <Type, AutoRouteFactory>{
    SplashPage: (data) {
      final args = data.getArgs<SplashPageArguments>(
        orElse: () => SplashPageArguments(),
      );
      return CupertinoPageRoute<dynamic>(
        builder: (context) => SplashPage(key: args.key),
        settings: data,
      );
    },
    AppScreen: (data) {
      final args = data.getArgs<AppScreenArguments>(
        orElse: () => AppScreenArguments(),
      );
      return CupertinoPageRoute<dynamic>(
        builder: (context) => AppScreen(key: args.key),
        settings: data,
      );
    },
    HistoryPage: (data) {
      final args = data.getArgs<HistoryPageArguments>(
        orElse: () => HistoryPageArguments(),
      );
      return CupertinoPageRoute<dynamic>(
        builder: (context) => HistoryPage(key: args.key),
        settings: data,
      );
    },
    SettingPage: (data) {
      final args = data.getArgs<SettingPageArguments>(
        orElse: () => SettingPageArguments(),
      );
      return CupertinoPageRoute<dynamic>(
        builder: (context) => SettingPage(key: args.key),
        settings: data,
      );
    },
    AboutPage: (data) {
      final args = data.getArgs<AboutPageArguments>(
        orElse: () => AboutPageArguments(),
      );
      return CupertinoPageRoute<dynamic>(
        builder: (context) => AboutPage(key: args.key),
        settings: data,
      );
    },
  };
}

/// ************************************************************************
/// Arguments holder classes
/// *************************************************************************

/// SplashPage arguments holder class
class SplashPageArguments {
  final Key key;
  SplashPageArguments({this.key});
}

/// AppScreen arguments holder class
class AppScreenArguments {
  final Key key;
  AppScreenArguments({this.key});
}

/// HistoryPage arguments holder class
class HistoryPageArguments {
  final Key key;
  HistoryPageArguments({this.key});
}

/// SettingPage arguments holder class
class SettingPageArguments {
  final Key key;
  SettingPageArguments({this.key});
}

/// AboutPage arguments holder class
class AboutPageArguments {
  final Key key;
  AboutPageArguments({this.key});
}
