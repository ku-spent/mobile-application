import 'package:animated_splash/animated_splash.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spent/presentation/app_screen.dart';
import 'package:spent/presentation/bloc/feed/feed_bloc.dart';
import 'package:spent/presentation/pages/welcome_page.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FeedBloc, FeedState>(
      builder: (context, state) {
        return AnimatedSplash(
          imagePath: 'assets/images/logo.png',
          home: WelcomePage(),
          customFunction: () {
            // BlocProvider.of<FeedBloc>(context).add(FetchFeed());
            return 2;
          },
          outputAndHome: {1: AppScreen(), 2: WelcomePage()},
          duration: 2000,
          type: AnimatedSplashType.BackgroundProcess,
        );
      },
    );
  }
}
