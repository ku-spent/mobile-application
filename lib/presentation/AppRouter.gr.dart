// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs

import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../domain/model/Following.dart';
import '../domain/model/ModelProvider.dart';
import 'bloc/query/query_bloc.dart';
import 'pages/app_screen.dart';
import 'pages/bookmark_page.dart';
import 'pages/hero_photo_view_page.dart';
import 'pages/history_page.dart';
import 'pages/query_page.dart';
import 'pages/search_page.dart';
import 'pages/setting_block_page.dart';
import 'pages/setting_following_page.dart';
import 'pages/setting_page.dart';
import 'pages/splash_page.dart';
import 'pages/view_url.dart';
import 'pages/welcome_page.dart';

class Routes {
  static const String splashPage = '/';
  static const String appScreen = '/home';
  static const String bookmarkPage = '/bookmark';
  static const String historyPage = '/history';
  static const String settingBlockPage = '/setting/blocks';
  static const String settingPage = '/setting';
  static const String searchPage = '/search';
  static const String welcomePage = '/welcome';
  static const String settingFollowingPage = '/following/setting';
  static const String viewUrl = '/news';
  static const String queryPage = '/query';
  static const String heroPhotoViewPage = '/hero-photo';
  static const all = <String>{
    splashPage,
    appScreen,
    bookmarkPage,
    historyPage,
    settingBlockPage,
    settingPage,
    searchPage,
    welcomePage,
    settingFollowingPage,
    viewUrl,
    queryPage,
    heroPhotoViewPage,
  };
}

class AppRouter extends RouterBase {
  @override
  List<RouteDef> get routes => _routes;
  final _routes = <RouteDef>[
    RouteDef(Routes.splashPage, page: SplashPage),
    RouteDef(Routes.appScreen, page: AppScreen),
    RouteDef(Routes.bookmarkPage, page: BookmarkPage),
    RouteDef(Routes.historyPage, page: HistoryPage),
    RouteDef(Routes.settingBlockPage, page: SettingBlockPage),
    RouteDef(Routes.settingPage, page: SettingPage),
    RouteDef(Routes.searchPage, page: SearchPage),
    RouteDef(Routes.welcomePage, page: WelcomePage),
    RouteDef(Routes.settingFollowingPage, page: SettingFollowingPage),
    RouteDef(Routes.viewUrl, page: ViewUrl),
    RouteDef(Routes.queryPage, page: QueryPage),
    RouteDef(Routes.heroPhotoViewPage, page: HeroPhotoViewPage),
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
    BookmarkPage: (data) {
      final args = data.getArgs<BookmarkPageArguments>(
        orElse: () => BookmarkPageArguments(),
      );
      return CupertinoPageRoute<dynamic>(
        builder: (context) => BookmarkPage(key: args.key),
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
    SettingBlockPage: (data) {
      final args = data.getArgs<SettingBlockPageArguments>(
        orElse: () => SettingBlockPageArguments(),
      );
      return CupertinoPageRoute<dynamic>(
        builder: (context) => SettingBlockPage(key: args.key),
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
    SearchPage: (data) {
      return CupertinoPageRoute<dynamic>(
        builder: (context) => const SearchPage(),
        settings: data,
      );
    },
    WelcomePage: (data) {
      final args = data.getArgs<WelcomePageArguments>(
        orElse: () => WelcomePageArguments(),
      );
      return CupertinoPageRoute<dynamic>(
        builder: (context) => WelcomePage(key: args.key),
        settings: data,
      );
    },
    SettingFollowingPage: (data) {
      final args = data.getArgs<SettingFollowingPageArguments>(nullOk: false);
      return CupertinoPageRoute<dynamic>(
        builder: (context) => SettingFollowingPage(
          key: args.key,
          followingList: args.followingList,
          followingType: args.followingType,
        ),
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
          coverUrl: args.coverUrl,
          isShowTitle: args.isShowTitle,
        ),
        settings: data,
      );
    },
    HeroPhotoViewPage: (data) {
      final args = data.getArgs<HeroPhotoViewPageArguments>(nullOk: false);
      return MaterialPageRoute<dynamic>(
        builder: (context) => HeroPhotoViewPage(
          tag: args.tag,
          imageProvider: args.imageProvider,
          backgroundDecoration: args.backgroundDecoration,
          minScale: args.minScale,
          maxScale: args.maxScale,
        ),
        settings: data,
        fullscreenDialog: true,
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

/// BookmarkPage arguments holder class
class BookmarkPageArguments {
  final Key key;
  BookmarkPageArguments({this.key});
}

/// HistoryPage arguments holder class
class HistoryPageArguments {
  final Key key;
  HistoryPageArguments({this.key});
}

/// SettingBlockPage arguments holder class
class SettingBlockPageArguments {
  final Key key;
  SettingBlockPageArguments({this.key});
}

/// SettingPage arguments holder class
class SettingPageArguments {
  final Key key;
  SettingPageArguments({this.key});
}

/// WelcomePage arguments holder class
class WelcomePageArguments {
  final Key key;
  WelcomePageArguments({this.key});
}

/// SettingFollowingPage arguments holder class
class SettingFollowingPageArguments {
  final Key key;
  final List<Following> followingList;
  final FollowingType followingType;
  SettingFollowingPageArguments(
      {this.key, @required this.followingList, @required this.followingType});
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
  final QueryObject query;
  final String coverUrl;
  final bool isShowTitle;
  QueryPageArguments(
      {this.key,
      @required this.query,
      @required this.coverUrl,
      this.isShowTitle = false});
}

/// HeroPhotoViewPage arguments holder class
class HeroPhotoViewPageArguments {
  final String tag;
  final ImageProvider<Object> imageProvider;
  final Decoration backgroundDecoration;
  final dynamic minScale;
  final dynamic maxScale;
  HeroPhotoViewPageArguments(
      {@required this.tag,
      @required this.imageProvider,
      this.backgroundDecoration,
      this.minScale,
      this.maxScale});
}
