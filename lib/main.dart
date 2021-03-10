import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'package:spent/presentation/AppRouter.gr.dart';
import 'package:spent/presentation/bloc/block/block_bloc.dart';
import 'package:spent/presentation/bloc/explore/explore_bloc.dart';
import 'package:spent/presentation/bloc/history/history_bloc.dart';
import 'package:spent/presentation/bloc/like_news/like_news_bloc.dart';
import 'package:spent/presentation/bloc/manage_block/manage_block_bloc.dart';
import 'package:spent/presentation/bloc/manage_bookmark/manage_bookmark_bloc.dart';
import 'package:spent/presentation/bloc/manage_history/manage_history_bloc.dart';
import 'package:spent/presentation/bloc/share_news/share_news_bloc.dart';
import 'package:spent/presentation/pages/splash_page.dart';

import 'package:spent/presentation/theme.dart';
import 'package:spent/domain/model/News.dart';

import 'package:spent/presentation/bloc/user_event/user_event_bloc.dart';
import 'package:spent/presentation/bloc/authentication/authentication_bloc.dart';
import 'package:spent/presentation/bloc/bookmark/bookmark_bloc.dart';
import 'package:spent/presentation/bloc/network/network_bloc.dart';
import 'package:spent/presentation/bloc/signin/signin_bloc.dart';
import 'package:spent/presentation/bloc/search/search_bloc.dart';
import 'package:spent/presentation/bloc/query/query_bloc.dart';
import 'package:spent/di/di.dart';
import 'package:bot_toast/bot_toast.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  configureInjection(Environment.dev);
  await Hive.initFlutter();
  Hive.registerAdapter(NewsAdapter());
  initializeDateFormatting('th_TH');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final botToastBuilder = BotToastInit();

  MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<NetworkBloc>(
          create: (BuildContext context) => getIt<NetworkBloc>(),
        ),
        BlocProvider<ExploreBloc>(
          create: (BuildContext context) => getIt<ExploreBloc>(),
        ),
        BlocProvider<BlockBloc>(
          create: (BuildContext context) => getIt<BlockBloc>(),
        ),
        BlocProvider<SearchBloc>(
          create: (BuildContext context) => getIt<SearchBloc>(),
        ),
        // BlocProvider<QueryFeedBloc>(
        //   create: (BuildContext context) => getIt<QueryFeedBloc>(),
        // ),
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
        BlocProvider<ManageBookmarkBloc>(
          create: (BuildContext context) => getIt<ManageBookmarkBloc>(),
        ),
        BlocProvider<ManageHistoryBloc>(
          create: (BuildContext context) => getIt<ManageHistoryBloc>(),
        ),
        BlocProvider<ManageBlockBloc>(
          create: (BuildContext context) => getIt<ManageBlockBloc>(),
        ),
        BlocProvider<LikeNewsBloc>(
          create: (BuildContext context) => getIt<LikeNewsBloc>(),
        ),
        BlocProvider<ShareNewsBloc>(
          create: (BuildContext context) => getIt<ShareNewsBloc>(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'SPENT',
        theme: MyTheme(context: context).mainTheme,
        builder: ExtendedNavigator.builder(
          router: AppRouter(),
          builder: (context, child) {
            child = botToastBuilder(context, child);
            return child;
          },
        ),
        navigatorObservers: [BotToastNavigatorObserver()],
        home: SplashPage(),
      ),
    );
  }
}
