// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:flutter/widgets.dart';

import '../data/http_manager/app_http_manager.dart';
import '../presentation/bloc/feed/feed_bloc.dart';
import '../domain/use_case/get_news_feed_use_case.dart';
import '../data/http_manager/http_manager.dart';
import '../presentation/bloc/navigation/navigation_bloc.dart';
import '../data/data_source/news/news_data_source.dart';
import '../data/data_source/news/news_remote_data_source.dart';
import '../data/repository/news_repository.dart';
import '../presentation/bloc/query/query_bloc.dart';
import '../presentation/bloc/search/search_bloc.dart';
import '../data/data_source/search_item/search_item_data_source.dart';
import '../data/data_source/search_item/search_item_fuse.dart';
import '../data/data_source/search_item/search_item_remote_data_source.dart';
import '../data/repository/search_repository.dart';
import '../domain/use_case/search_use_case.dart';

/// adds generated dependencies
/// to the provided [GetIt] instance

GetIt $initGetIt(
  GetIt get, {
  String environment,
  EnvironmentFilter environmentFilter,
}) {
  final gh = GetItHelper(get, environment, environmentFilter);
  gh.factory<HttpManager>(() => AppHttpManager());
  gh.factoryParam<NavigationBloc, PageController, dynamic>((pageController, _) => NavigationBloc(pageController));
  gh.factory<NewsDataSource>(() => NewsRemoteDataSource(get<HttpManager>()));
  gh.factory<NewsRepository>(() => NewsRepository(get<NewsDataSource>()));
  gh.factory<SearchItemFuse>(() => SearchItemFuse());
  gh.factory<GetNewsFeedUseCase>(() => GetNewsFeedUseCase(get<NewsRepository>()));
  gh.factory<QueryFeedBloc>(() => QueryFeedBloc(get<GetNewsFeedUseCase>()));
  gh.factory<SearchItemDataSource>(() => SearchRemoteDataSource(get<SearchItemFuse>()));
  gh.factory<SearchRepository>(() => SearchRepository(get<SearchItemDataSource>()));
  gh.factory<SearchUseCase>(() => SearchUseCase(get<SearchRepository>()));
  gh.factory<FeedBloc>(() => FeedBloc(get<GetNewsFeedUseCase>()));
  gh.factory<SearchBloc>(() => SearchBloc(get<SearchUseCase>()));
  return get;
}
