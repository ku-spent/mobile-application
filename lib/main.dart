import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:spent/presentation/AppRouter.gr.dart';
import 'package:spent/presentation/bloc/history/history_bloc.dart';
import 'package:spent/presentation/bloc/save_bookmark/save_bookmark_bloc.dart';
import 'package:spent/presentation/bloc/save_history/save_history_bloc.dart';

import 'package:spent/presentation/theme.dart';
import 'package:spent/domain/model/News.dart';

import 'package:spent/presentation/bloc/user_event/user_event_bloc.dart';
import 'package:spent/presentation/bloc/authentication/authentication_bloc.dart';
import 'package:spent/presentation/bloc/bookmark/bookmark_bloc.dart';
import 'package:spent/presentation/bloc/network/network_bloc.dart';
import 'package:spent/presentation/bloc/signin/signin_bloc.dart';
import 'package:spent/presentation/bloc/feed/feed_bloc.dart';
import 'package:spent/presentation/bloc/search/search_bloc.dart';
import 'package:spent/presentation/bloc/query/query_bloc.dart';
import 'package:spent/di/di.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  configureInjection(Environment.dev);
  await Hive.initFlutter();
  Hive.registerAdapter(NewsAdapter());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<NetworkBloc>(
          create: (BuildContext context) => getIt<NetworkBloc>(),
        ),
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
        ),
        BlocProvider<BookmarkBloc>(
          create: (BuildContext context) => getIt<BookmarkBloc>(),
        ),
        BlocProvider<SaveBookmarkBloc>(
          create: (BuildContext context) => getIt<SaveBookmarkBloc>(),
        ),
        BlocProvider<SaveHistoryBloc>(
          create: (BuildContext context) => getIt<SaveHistoryBloc>(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'SPENT',
        theme: MyTheme(context: context).mainTheme,
        builder: ExtendedNavigator.builder(router: AppRouter(), builder: (context, extendedNav) => extendedNav),
        // home: SplashPage(),
      ),
    );
  }
}
