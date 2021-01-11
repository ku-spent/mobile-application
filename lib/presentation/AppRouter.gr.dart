// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs

import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../domain/model/ModelProvider.dart';
import 'pages/about_page.dart';
import 'pages/app_screen.dart';
import 'pages/history_page.dart';
import 'pages/query_page.dart';
import 'pages/search_page.dart';
import 'pages/setting_page.dart';
import 'pages/splash_page.dart';
import 'pages/view_url.dart';

class Routes {
  static const String splashPage = '/';
  static const String appScreen = '/home';
  static const String historyPage = '/bookmark';
  static const String settingPage = '/setting';
  static const String aboutPage = '/about';
  static const String searchPage = '/search';
  static const String viewUrl = '/news';
  static const String queryPage = '/query';
  static const all = <String>{
    splashPage,
    appScreen,
    historyPage,
    settingPage,
    aboutPage,
    searchPage,
    viewUrl,
    queryPage,
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
    RouteDef(Routes.searchPage, page: SearchPage),
    RouteDef(Routes.viewUrl, page: ViewUrl),
    RouteDef(Routes.queryPage, page: QueryPage),
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
    SearchPage: (data) {
      return CupertinoPageRoute<dynamic>(
        builder: (context) => const SearchPage(),
        settings: data,
      );
    },
    ViewUrl: (data) {
      final args = data.getArgs<ViewUrlArguments>(nullOk: false);
      return MaterialPageRoute<dynamic>(
        builder: (context) => ViewUrl(
          key: args.key,
          news: args.news,
        ),
        settings: data,
      );
    },
    QueryPage: (data) {
      final args = data.getArgs<QueryPageArguments>(nullOk: false);
      return MaterialPageRoute<dynamic>(
        builder: (context) => QueryPage(
          key: args.key,
          query: args.query,
          queryField: args.queryField,
          coverUrl: args.coverUrl,
          isShowTitle: args.isShowTitle,
        ),
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

/// ViewUrl arguments holder class
class ViewUrlArguments {
  final Key key;
  final News news;
  ViewUrlArguments({this.key, @required this.news});
}

/// QueryPage arguments holder class
class QueryPageArguments {
  final Key key;
  final String query;
  final String queryField;
  final String coverUrl;
  final bool isShowTitle;
  QueryPageArguments(
      {this.key,
      @required this.query,
      @required this.queryField,
      @required this.coverUrl,
      this.isShowTitle = false});
}
