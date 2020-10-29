import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:animated_splash/animated_splash.dart';

import 'package:spent/ui/app_screen.dart';
import 'package:spent/ui/theme.dart';
import 'package:spent/repository/feed_repository.dart';

import 'package:spent/bloc/feed/feed_bloc.dart';
import 'package:spent/bloc/navigation/navigation_bloc.dart';
import 'package:spent/bloc/search/search_bloc.dart';
import 'package:spent/bloc/query/query_bloc.dart';

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
        BlocProvider<QueryFeed>(
          create: (BuildContext context) =>
              QueryFeed(feedRepository: _feedRepository),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'SPENT',
        theme: MyTheme(context: context).mainTheme,
        home: BlocBuilder<FeedBloc, FeedState>(
          builder: (context, state) {
            return AnimatedSplash(
              imagePath: 'assets/images/logo.png',
              home: AppScreen(
                pageController: _pageController,
              ),
              customFunction: () {
                BlocProvider.of<FeedBloc>(context).add(FetchFeed());
                return 1;
              },
              outputAndHome: {
                1: AppScreen(
                  pageController: _pageController,
                )
              },
              duration: 2000,
              type: AnimatedSplashType.BackgroundProcess,
            );
          },
        ),
      ),
    );
  }
}
