import 'package:auto_route/auto_route_annotations.dart';
import 'package:spent/presentation/pages/about_page.dart';
import 'package:spent/presentation/pages/app_screen.dart';
import 'package:spent/presentation/pages/history_page.dart';
import 'package:spent/presentation/pages/search_page.dart';
import 'package:spent/presentation/pages/setting_page.dart';
import 'package:spent/presentation/pages/splash_page.dart';
import 'package:spent/presentation/pages/view_url.dart';

@MaterialAutoRouter(
  routes: <AutoRoute>[
    CupertinoRoute(path: '/', page: SplashPage, initial: true),
    CupertinoRoute(path: '/home', page: AppScreen),
    CupertinoRoute(path: '/bookmark', page: HistoryPage),
    CupertinoRoute(path: '/setting', page: SettingPage),
    CupertinoRoute(path: '/about', page: AboutPage),
    CupertinoRoute(path: '/search', page: SearchPage),
    MaterialRoute(path: '/news', page: ViewUrl),
  ],
)
class $AppRouter {}
