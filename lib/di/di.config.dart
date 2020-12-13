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
import '../presentation/bloc/feed/feed_bloc.dart';
import '../domain/use_case/get_current_user_use_case.dart';
import '../domain/use_case/get_news_feed_use_case.dart';
import '../domain/use_case/initial_authentication_use_case.dart';
import '../presentation/bloc/navigation/navigation_bloc.dart';
import '../data/data_source/news/news_remote_data_source.dart';
import '../data/repository/news_repository.dart';
import '../presentation/bloc/query/query_bloc.dart';
import '../presentation/bloc/search/search_bloc.dart';
import '../data/data_source/search_item/search_item_data_source.dart';
import '../data/data_source/search_item/search_item_fuse.dart';
import '../data/data_source/search_item/search_item_remote_data_source.dart';
import '../data/repository/search_repository.dart';
import '../domain/use_case/search_use_case.dart';
import '../presentation/bloc/signin/signin_bloc.dart';
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
  gh.factory<InitialAuthenticationUseCase>(
      () => InitialAuthenticationUseCase(get<AuthenticationRepository>()));
  gh.factory<NewsRemoteDataSource>(
      () => NewsRemoteDataSource(get<AppHttpManager>()));
  gh.factory<NewsRepository>(() => NewsRepository(get<NewsRemoteDataSource>()));
  gh.factory<SearchItemFuse>(() => SearchItemFuse());
  gh.factory<UserSignInWithAmplifyUseCase>(
      () => UserSignInWithAmplifyUseCase(get<AuthenticationRepository>()));
  gh.factory<UserSignInWithAuthCodeUseCase>(
      () => UserSignInWithAuthCodeUseCase(get<AuthenticationRepository>()));
  gh.factory<UserSignOutUseCase>(
      () => UserSignOutUseCase(get<AuthenticationRepository>()));
  gh.factoryParam<UserStorage, SharedPreferences, dynamic>(
      (_prefs, _) => UserStorage(_prefs));
  gh.factory<GetNewsFeedUseCase>(() => GetNewsFeedUseCase(
      get<NewsRepository>(), get<AuthenticationRepository>()));
  gh.factoryParam<NavigationBloc, PageController, dynamic>(
      (pageController, _) =>
          NavigationBloc(pageController, get<AuthenticationBloc>()));
  gh.factory<QueryFeedBloc>(() => QueryFeedBloc(get<GetNewsFeedUseCase>()));
  gh.factory<SearchItemDataSource>(
      () => SearchRemoteDataSource(get<SearchItemFuse>()));
  gh.factory<SearchRepository>(
      () => SearchRepository(get<SearchItemDataSource>()));
  gh.factory<SearchUseCase>(() => SearchUseCase(get<SearchRepository>()));
  gh.factory<SigninBloc>(() => SigninBloc(
        get<UserSignInWithAuthCodeUseCase>(),
        get<AuthenticationBloc>(),
        get<UserSignInWithAmplifyUseCase>(),
      ));
  gh.factory<FeedBloc>(() => FeedBloc(get<GetNewsFeedUseCase>()));
  gh.factory<SearchBloc>(() => SearchBloc(get<SearchUseCase>()));

  // Eager singletons must be registered in the right order
  gh.singleton<AppHttpManager>(AppHttpManager());
  gh.singleton<AuthenticationRepository>(AuthenticationRepository(
      get<AuthenticationRemoteDataSource>(), get<AppHttpManager>()));
  gh.singleton<AuthenticationBloc>(AuthenticationBloc(
    get<GetCurrentUserUseCase>(),
    get<UserSignOutUseCase>(),
    get<InitialAuthenticationUseCase>(),
  ));
  return get;
}
