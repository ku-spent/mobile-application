import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import 'package:spent/presentation/bloc/authentication/authentication_bloc.dart';
import 'package:spent/presentation/bloc/history/history_bloc.dart';
import 'package:spent/presentation/bloc/signin/signin_bloc.dart';
import 'package:spent/presentation/bloc/user_event/user_event_bloc.dart';
import 'package:spent/presentation/pages/splash_page.dart';
import 'package:spent/presentation/theme.dart';

import 'package:spent/presentation/bloc/feed/feed_bloc.dart';
import 'package:spent/presentation/bloc/search/search_bloc.dart';
import 'package:spent/presentation/bloc/query/query_bloc.dart';
import 'package:spent/di/di.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  configureInjection(Environment.dev);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<FeedBloc>(
          create: (BuildContext context) => getIt<FeedBloc>(),
        ),
        BlocProvider<SearchBloc>(
          create: (BuildContext context) => getIt<SearchBloc>(),
        ),
        BlocProvider<QueryFeedBloc>(
          create: (BuildContext context) => getIt<QueryFeedBloc>(),
        ),
        BlocProvider<AuthenticationBloc>(
          create: (BuildContext context) => getIt<AuthenticationBloc>(),
        ),
        BlocProvider<SigninBloc>(
          create: (BuildContext context) => getIt<SigninBloc>(),
        ),
        BlocProvider<UserEventBloc>(
          create: (BuildContext context) => getIt<UserEventBloc>(),
        ),
        BlocProvider<HistoryBloc>(
          create: (BuildContext context) => getIt<HistoryBloc>(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'SPENT',
        theme: MyTheme(context: context).mainTheme,
        home: SplashPage(),
      ),
    );
  }
}
