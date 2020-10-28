import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:spent/bloc/feed/feed_bloc.dart';
import 'package:spent/bloc/navigation/navigation_bloc.dart';
import 'package:spent/bloc/search/search_bloc.dart';
import 'package:spent/repository/feed_repository.dart';
import 'package:spent/ui/app_screen.dart';
import 'package:spent/ui/theme.dart';
import 'package:http/http.dart' as http;
import 'package:splashscreen/splashscreen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final PageController _pageController = PageController(
    initialPage: 0,
  );

  final FeedRepository _feedRepository = FeedRepository(client: http.Client());

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<FeedBloc>(
              create: (BuildContext context) =>
                  FeedBloc(feedRepository: _feedRepository)),
          BlocProvider<NavigationBloc>(
              create: (BuildContext context) =>
                  NavigationBloc(pageController: _pageController)),
          BlocProvider<SearchBloc>(
              create: (BuildContext context) => SearchBloc()),
          // BlocProvider<SourceBloc>(
          //   create: (BuildContext context) =>
          //       SourceBloc(feedRepository: _feedRepository),
          // )
        ],
        child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'SPENT',
            theme: MyTheme(context: context).mainTheme,
            home: SplashScreen(
                seconds: 1,
                navigateAfterSeconds: AppScreen(
                  pageController: _pageController,
                ),
                title: Text(
                  'SPENT',
                  style: GoogleFonts.kanit(),
                ),
                image: Image.asset('assets/images/logo.png'),
                backgroundColor: Colors.white,
                styleTextUnderTheLoader: TextStyle(color: Colors.deepPurple),
                photoSize: 100.0,
                loaderColor: Theme.of(context).primaryColor)));
  }
}
