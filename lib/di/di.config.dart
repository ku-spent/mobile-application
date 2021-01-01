// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/http_manager/app_http_manager.dart';
import '../presentation/bloc/authentication/authentication_bloc.dart';
import '../data/data_source/authentication/authentication_local_data_souce.dart';
import '../data/data_source/authentication/authentication_remote_data_source.dart';
import '../data/repository/authentication_repository.dart';
import '../presentation/bloc/bookmark/bookmark_bloc.dart';
import '../presentation/bloc/feed/feed_bloc.dart';
import '../domain/use_case/get_bookmark_use_case.dart';
import '../domain/use_case/get_current_user_use_case.dart';
import '../domain/use_case/get_news_feed_use_case.dart';
import '../domain/use_case/get_view_news_history_use_case.dart';
import '../presentation/bloc/history/history_bloc.dart';
import '../core/IPv6.dart';
import '../domain/use_case/identify_user_use_case.dart';
import '../domain/use_case/initial_authentication_use_case.dart';
import '../presentation/bloc/like_news/like_news_bloc.dart';
import '../domain/use_case/like_news_use_case.dart';
import '../data/data_source/local_storage/local_storage.dart';
import '../presentation/bloc/navigation/navigation_bloc.dart';
import '../presentation/bloc/network/network_bloc.dart';
import '../presentation/bloc/news/news_bloc.dart';
import '../data/data_source/news/news_local_data_source.dart';
import '../data/data_source/news/news_remote_data_source.dart';
import '../data/repository/news_repository.dart';
import '../presentation/bloc/query/query_bloc.dart';
import '../presentation/bloc/save_bookmark/save_bookmark_bloc.dart';
import '../domain/use_case/save_bookmark_use_case.dart';
import '../presentation/bloc/save_history/save_history_bloc.dart';
import '../domain/use_case/save_user_view_news_history_use_case.dart';
import '../presentation/bloc/search/search_bloc.dart';
import '../data/data_source/search_item/search_item_data_source.dart';
import '../data/data_source/search_item/search_item_fuse.dart';
import '../data/data_source/search_item/search_item_remote_data_source.dart';
import '../data/repository/search_repository.dart';
import '../domain/use_case/search_use_case.dart';
import '../domain/use_case/send_event_view_news_use_case.dart';
import '../presentation/bloc/signin/signin_bloc.dart';
import '../presentation/bloc/user_event/user_event_bloc.dart';
import '../data/repository/user_event_repository.dart';
import '../data/repository/user_repository.dart';
import '../domain/use_case/user_signin_with_amplify_use_case.dart';
import '../domain/use_case/user_signin_with_authcode_use_case.dart';
import '../domain/use_case/user_signout_use_case.dart';
import '../data/data_source/user_storage/user_storage.dart';

/// adds generated dependencies
/// to the provided [GetIt] instance

GetIt $initGetIt(
  GetIt get, {
  String environment,
  EnvironmentFilter environmentFilter,
}) {
  final gh = GetItHelper(get, environment, environmentFilter);
  gh.factory<AuthenticationLocalDataSource>(
      () => AuthenticationLocalDataSource());
  gh.factory<AuthenticationRemoteDataSource>(
      () => AuthenticationRemoteDataSource(get<AppHttpManager>()));
  gh.factory<GetCurrentUserUseCase>(
      () => GetCurrentUserUseCase(get<AuthenticationRepository>()));
  gh.factory<IdentifyUserUseCase>(
      () => IdentifyUserUseCase(get<AuthenticationRepository>()));
  gh.factory<InitialAuthenticationUseCase>(
      () => InitialAuthenticationUseCase(get<AuthenticationRepository>()));
  gh.factoryParam<LocalStorage, SharedPreferences, dynamic>(
      (_prefs, _) => LocalStorage(_prefs));
  gh.factory<NewsLocalDataSource>(() => NewsLocalDataSource());
  gh.factory<NewsRemoteDataSource>(
      () => NewsRemoteDataSource(get<AppHttpManager>()));
  gh.factory<NewsRepository>(() =>
      NewsRepository(get<NewsRemoteDataSource>(), get<NewsLocalDataSource>()));
  gh.factory<SearchItemFuse>(() => SearchItemFuse());
  gh.factory<SendEventViewNewsUseCase>(() => SendEventViewNewsUseCase());
  gh.factory<UserEventRepository>(() => UserEventRepository());
  gh.factory<UserSignInWithAmplifyUseCase>(
      () => UserSignInWithAmplifyUseCase(get<AuthenticationRepository>()));
  gh.factory<UserSignInWithAuthCodeUseCase>(
      () => UserSignInWithAuthCodeUseCase(get<AuthenticationRepository>()));
  gh.factory<UserSignOutUseCase>(
      () => UserSignOutUseCase(get<AuthenticationRepository>()));
  gh.factory<GetNewsFeedUseCase>(
      () => GetNewsFeedUseCase(get<NewsRepository>()));
  gh.factoryParam<NavigationBloc, PageController, dynamic>(
      (pageController, _) =>
          NavigationBloc(pageController, get<AuthenticationBloc>()));
  gh.factory<QueryFeedBloc>(
      () => QueryFeedBloc(get<GetNewsFeedUseCase>(), get<NetworkBloc>()));
  gh.factory<SearchItemDataSource>(
      () => SearchRemoteDataSource(get<SearchItemFuse>()));
  gh.factory<SearchRepository>(
      () => SearchRepository(get<SearchItemDataSource>()));
  gh.factory<SearchUseCase>(() => SearchUseCase(get<SearchRepository>()));
  gh.factory<SigninBloc>(() => SigninBloc(
        get<AuthenticationBloc>(),
        get<UserSignInWithAmplifyUseCase>(),
        get<IdentifyUserUseCase>(),
      ));
  gh.factory<FeedBloc>(
      () => FeedBloc(get<GetNewsFeedUseCase>(), get<NetworkBloc>()));
  gh.factory<GetBookmarkUseCase>(() => GetBookmarkUseCase(
        get<AuthenticationRepository>(),
        get<UserRepository>(),
        get<NewsRepository>(),
      ));
  gh.factory<GetViewNewsHistoryUseCase>(() => GetViewNewsHistoryUseCase(
        get<AuthenticationRepository>(),
        get<UserRepository>(),
        get<NewsRepository>(),
      ));
  gh.factory<LikeNewsUseCase>(() =>
      LikeNewsUseCase(get<AuthenticationRepository>(), get<UserRepository>()));
  gh.factory<SaveBookmarkUseCase>(() => SaveBookmarkUseCase(
      get<AuthenticationRepository>(), get<UserRepository>()));
  gh.factory<SaveUserViewNewsHistoryUseCase>(() =>
      SaveUserViewNewsHistoryUseCase(
          get<AuthenticationRepository>(), get<UserRepository>()));
  gh.factory<SearchBloc>(() => SearchBloc(get<SearchUseCase>()));

  // Eager singletons must be registered in the right order
  gh.singleton<AppHttpManager>(AppHttpManager());
  gh.singleton<AuthenticationRepository>(AuthenticationRepository(
      get<AuthenticationRemoteDataSource>(), get<AppHttpManager>()));
  gh.singleton<IPv6>(IPv6());
  gh.singleton<NetworkBloc>(NetworkBloc(get<IPv6>()));
  gh.singleton<UserStorage>(UserStorage());
  gh.singleton<AuthenticationBloc>(AuthenticationBloc(
    get<GetCurrentUserUseCase>(),
    get<UserSignOutUseCase>(),
    get<InitialAuthenticationUseCase>(),
    get<IdentifyUserUseCase>(),
  ));
  gh.singleton<UserRepository>(UserRepository(get<UserStorage>()));
  gh.singleton<HistoryBloc>(HistoryBloc(get<GetViewNewsHistoryUseCase>()));
  gh.singleton<BookmarkBloc>(BookmarkBloc(get<GetBookmarkUseCase>()));
  gh.singleton<LikeNewsBloc>(LikeNewsBloc(get<LikeNewsUseCase>()));
  gh.singleton<SaveBookmarkBloc>(SaveBookmarkBloc(get<SaveBookmarkUseCase>()));
  gh.singleton<SaveHistoryBloc>(
      SaveHistoryBloc(get<SaveUserViewNewsHistoryUseCase>()));
  gh.singleton<UserEventBloc>(
      UserEventBloc(get<SendEventViewNewsUseCase>(), get<SaveHistoryBloc>()));
  gh.singleton<NewsBloc>(NewsBloc(
    get<SaveBookmarkBloc>(),
    get<SaveHistoryBloc>(),
    get<LikeNewsBloc>(),
  ));
  return get;
}
