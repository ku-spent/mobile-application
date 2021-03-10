// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:flutter/widgets.dart' as _i31;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../core/IPv6.dart' as _i57;
import '../data/data_source/authentication/authentication_remote_data_source.dart'
    as _i4;
import '../data/data_source/news/news_local_data_source.dart' as _i10;
import '../data/data_source/news/news_remote_data_source.dart' as _i11;
import '../data/data_source/search_item/search_item_fuse.dart' as _i13;
import '../data/data_source/search_item/search_local_data_source.dart' as _i14;
import '../data/data_source/search_item/search_remote_data_source.dart' as _i15;
import '../data/data_source/trending/trending_remote_data_source.dart' as _i23;
import '../data/data_source/user_storage/user_storage.dart' as _i58;
import '../data/http_manager/amplify_http_manager.dart' as _i3;
import '../data/http_manager/app_http_manager.dart' as _i5;
import '../data/repository/authentication_repository.dart' as _i7;
import '../data/repository/explore.repository.dart' as _i29;
import '../data/repository/news_repository.dart' as _i12;
import '../data/repository/search_repository.dart' as _i16;
import '../data/repository/user_event_repository.dart' as _i25;
import '../data/repository/user_repository.dart' as _i36;
import '../domain/use_case/delete_block_use_case.dart' as _i35;
import '../domain/use_case/delete_bookmark_use_case.dart' as _i37;
import '../domain/use_case/delete_user_view_news_history_use_case.dart' as _i38;
import '../domain/use_case/event/send_event_bookmark_news_use_case.dart'
    as _i18;
import '../domain/use_case/event/send_event_like_news_use_case.dart' as _i19;
import '../domain/use_case/event/send_event_share_news_use_case.dart' as _i20;
import '../domain/use_case/event/send_event_view_news_use_case.dart' as _i21;
import '../domain/use_case/get_blocks_use_case.dart' as _i39;
import '../domain/use_case/get_bookmark_use_case.dart' as _i40;
import '../domain/use_case/get_current_user_use_case.dart' as _i6;
import '../domain/use_case/get_explore_use_case.dart' as _i41;
import '../domain/use_case/get_news_feed_trend_use_case.dart' as _i42;
import '../domain/use_case/get_news_feed_use_case.dart' as _i43;
import '../domain/use_case/get_recommendation_use_case.dart' as _i44;
import '../domain/use_case/get_suggestion_use_case.dart' as _i45;
import '../domain/use_case/get_view_news_history_use_case.dart' as _i46;
import '../domain/use_case/identify_user_use_case.dart' as _i8;
import '../domain/use_case/initial_authentication_use_case.dart' as _i9;
import '../domain/use_case/like_news_use_case.dart' as _i47;
import '../domain/use_case/save_block_use_case.dart' as _i51;
import '../domain/use_case/save_bookmark_use_case.dart' as _i52;
import '../domain/use_case/save_user_view_news_history_use_case.dart' as _i53;
import '../domain/use_case/search_use_case.dart' as _i17;
import '../domain/use_case/share_news_use_case.dart' as _i22;
import '../domain/use_case/user_signin_with_amplify_use_case.dart' as _i26;
import '../domain/use_case/user_signin_with_authcode_use_case.dart' as _i27;
import '../domain/use_case/user_signout_use_case.dart' as _i28;
import '../presentation/bloc/authentication/authentication_bloc.dart' as _i32;
import '../presentation/bloc/block/block_bloc.dart' as _i61;
import '../presentation/bloc/bookmark/bookmark_bloc.dart' as _i62;
import '../presentation/bloc/explore/explore_bloc.dart' as _i55;
import '../presentation/bloc/feed/feed_bloc.dart' as _i56;
import '../presentation/bloc/history/history_bloc.dart' as _i60;
import '../presentation/bloc/like_news/like_news_bloc.dart' as _i63;
import '../presentation/bloc/manage_block/manage_block_bloc.dart' as _i64;
import '../presentation/bloc/manage_bookmark/manage_bookmark_bloc.dart' as _i65;
import '../presentation/bloc/manage_history/manage_history_bloc.dart' as _i66;
import '../presentation/bloc/navigation/navigation_bloc.dart' as _i30;
import '../presentation/bloc/network/network_bloc.dart' as _i49;
import '../presentation/bloc/news/news_bloc.dart' as _i67;
import '../presentation/bloc/query/query_bloc.dart' as _i48;
import '../presentation/bloc/recommendation/recommendation_bloc.dart' as _i50;
import '../presentation/bloc/search/search_bloc.dart' as _i33;
import '../presentation/bloc/share_news/share_news_bloc.dart' as _i59;
import '../presentation/bloc/signin/signin_bloc.dart' as _i34;
import '../presentation/bloc/suggest/suggest_bloc.dart' as _i54;
import '../presentation/bloc/user_event/user_event_bloc.dart'
    as _i24; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(_i1.GetIt get,
    {String environment, _i2.EnvironmentFilter environmentFilter}) {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  gh.factory<_i3.AmplifyHttpManager>(() => _i3.AmplifyHttpManager());
  gh.factory<_i4.AuthenticationRemoteDataSource>(
      () => _i4.AuthenticationRemoteDataSource(get<_i5.AppHttpManager>()));
  gh.factory<_i6.GetCurrentUserUseCase>(
      () => _i6.GetCurrentUserUseCase(get<_i7.AuthenticationRepository>()));
  gh.factory<_i8.IdentifyUserUseCase>(
      () => _i8.IdentifyUserUseCase(get<_i7.AuthenticationRepository>()));
  gh.factory<_i9.InitialAuthenticationUseCase>(() =>
      _i9.InitialAuthenticationUseCase(get<_i7.AuthenticationRepository>()));
  gh.factory<_i10.NewsLocalDataSource>(() => _i10.NewsLocalDataSource());
  gh.factory<_i11.NewsRemoteDataSource>(
      () => _i11.NewsRemoteDataSource(get<_i3.AmplifyHttpManager>()));
  gh.factory<_i12.NewsRepository>(() => _i12.NewsRepository(
      get<_i11.NewsRemoteDataSource>(), get<_i10.NewsLocalDataSource>()));
  gh.factory<_i13.SearchItemFuse>(() => _i13.SearchItemFuse());
  gh.factory<_i14.SearchLocalDataSource>(
      () => _i14.SearchLocalDataSource(get<_i13.SearchItemFuse>()));
  gh.factory<_i15.SearchRemoteDataSource>(
      () => _i15.SearchRemoteDataSource(get<_i3.AmplifyHttpManager>()));
  gh.factory<_i16.SearchRepository>(() => _i16.SearchRepository(
      get<_i15.SearchRemoteDataSource>(), get<_i14.SearchLocalDataSource>()));
  gh.factory<_i17.SearchUseCase>(
      () => _i17.SearchUseCase(get<_i16.SearchRepository>()));
  gh.factory<_i18.SendEventBookmarkNewsUseCase>(
      () => _i18.SendEventBookmarkNewsUseCase());
  gh.factory<_i19.SendEventLikeNewsUseCase>(
      () => _i19.SendEventLikeNewsUseCase());
  gh.factory<_i20.SendEventShareNewsUseCase>(
      () => _i20.SendEventShareNewsUseCase());
  gh.factory<_i21.SendEventViewNewsUseCase>(
      () => _i21.SendEventViewNewsUseCase());
  gh.factory<_i22.ShareNewsUseCase>(() => _i22.ShareNewsUseCase());
  gh.factory<_i23.TrendingRemoteDataSource>(
      () => _i23.TrendingRemoteDataSource(get<_i3.AmplifyHttpManager>()));
  gh.factory<_i24.UserEventBloc>(() => _i24.UserEventBloc(
      get<_i21.SendEventViewNewsUseCase>(),
      get<_i18.SendEventBookmarkNewsUseCase>(),
      get<_i19.SendEventLikeNewsUseCase>(),
      get<_i20.SendEventShareNewsUseCase>()));
  gh.factory<_i25.UserEventRepository>(() => _i25.UserEventRepository());
  gh.factory<_i26.UserSignInWithAmplifyUseCase>(() =>
      _i26.UserSignInWithAmplifyUseCase(get<_i7.AuthenticationRepository>()));
  gh.factory<_i27.UserSignInWithAuthCodeUseCase>(() =>
      _i27.UserSignInWithAuthCodeUseCase(get<_i7.AuthenticationRepository>()));
  gh.factory<_i28.UserSignOutUseCase>(
      () => _i28.UserSignOutUseCase(get<_i7.AuthenticationRepository>()));
  gh.factory<_i29.ExploreRepository>(
      () => _i29.ExploreRepository(get<_i23.TrendingRemoteDataSource>()));
  gh.factoryParam<_i30.NavigationBloc, _i31.PageController, dynamic>(
      (pageController, _) =>
          _i30.NavigationBloc(pageController, get<_i32.AuthenticationBloc>()));
  gh.factory<_i33.SearchBloc>(() => _i33.SearchBloc(get<_i17.SearchUseCase>()));
  gh.factory<_i34.SigninBloc>(() => _i34.SigninBloc(
      get<_i32.AuthenticationBloc>(),
      get<_i26.UserSignInWithAmplifyUseCase>(),
      get<_i8.IdentifyUserUseCase>()));
  gh.factory<_i35.DeleteBlockUseCase>(() => _i35.DeleteBlockUseCase(
      get<_i7.AuthenticationRepository>(), get<_i36.UserRepository>()));
  gh.factory<_i37.DeleteBookmarkUseCase>(() => _i37.DeleteBookmarkUseCase(
      get<_i7.AuthenticationRepository>(), get<_i36.UserRepository>()));
  gh.factory<_i38.DeleteUserViewNewsHistoryUseCase>(() =>
      _i38.DeleteUserViewNewsHistoryUseCase(
          get<_i7.AuthenticationRepository>(), get<_i36.UserRepository>()));
  gh.factory<_i39.GetBlocksUseCase>(() => _i39.GetBlocksUseCase(
      get<_i7.AuthenticationRepository>(), get<_i36.UserRepository>()));
  gh.factory<_i40.GetBookmarkUseCase>(() => _i40.GetBookmarkUseCase(
      get<_i7.AuthenticationRepository>(),
      get<_i36.UserRepository>(),
      get<_i12.NewsRepository>()));
  gh.factory<_i41.GetExploreUseCase>(() => _i41.GetExploreUseCase(
      get<_i29.ExploreRepository>(),
      get<_i36.UserRepository>(),
      get<_i7.AuthenticationRepository>()));
  gh.factory<_i42.GetNewsFeedTrendUseCase>(() => _i42.GetNewsFeedTrendUseCase(
      get<_i12.NewsRepository>(),
      get<_i36.UserRepository>(),
      get<_i7.AuthenticationRepository>()));
  gh.factory<_i43.GetNewsFeedUseCase>(() => _i43.GetNewsFeedUseCase(
      get<_i12.NewsRepository>(),
      get<_i36.UserRepository>(),
      get<_i7.AuthenticationRepository>()));
  gh.factory<_i44.GetRecommendationsUseCase>(() =>
      _i44.GetRecommendationsUseCase(get<_i12.NewsRepository>(),
          get<_i36.UserRepository>(), get<_i7.AuthenticationRepository>()));
  gh.factory<_i45.GetSuggestionNewsUseCase>(() => _i45.GetSuggestionNewsUseCase(
      get<_i12.NewsRepository>(),
      get<_i36.UserRepository>(),
      get<_i7.AuthenticationRepository>()));
  gh.factory<_i46.GetViewNewsHistoryUseCase>(() =>
      _i46.GetViewNewsHistoryUseCase(get<_i7.AuthenticationRepository>(),
          get<_i36.UserRepository>(), get<_i12.NewsRepository>()));
  gh.factory<_i47.LikeNewsUseCase>(() => _i47.LikeNewsUseCase(
      get<_i7.AuthenticationRepository>(), get<_i36.UserRepository>()));
  gh.factory<_i48.QueryFeedBloc>(() => _i48.QueryFeedBloc(
      get<_i43.GetNewsFeedUseCase>(),
      get<_i42.GetNewsFeedTrendUseCase>(),
      get<_i49.NetworkBloc>()));
  gh.factory<_i50.RecommendationBloc>(() => _i50.RecommendationBloc(
      get<_i44.GetRecommendationsUseCase>(), get<_i49.NetworkBloc>()));
  gh.factory<_i51.SaveBlockUseCase>(() => _i51.SaveBlockUseCase(
      get<_i7.AuthenticationRepository>(), get<_i36.UserRepository>()));
  gh.factory<_i52.SaveBookmarkUseCase>(() => _i52.SaveBookmarkUseCase(
      get<_i7.AuthenticationRepository>(), get<_i36.UserRepository>()));
  gh.factory<_i53.SaveUserViewNewsHistoryUseCase>(() =>
      _i53.SaveUserViewNewsHistoryUseCase(
          get<_i7.AuthenticationRepository>(), get<_i36.UserRepository>()));
  gh.factory<_i54.SuggestFeedBloc>(() => _i54.SuggestFeedBloc(
      get<_i45.GetSuggestionNewsUseCase>(), get<_i49.NetworkBloc>()));
  gh.factory<_i55.ExploreBloc>(
      () => _i55.ExploreBloc(get<_i41.GetExploreUseCase>()));
  gh.factory<_i56.FeedBloc>(() =>
      _i56.FeedBloc(get<_i43.GetNewsFeedUseCase>(), get<_i49.NetworkBloc>()));
  gh.singleton<_i5.AppHttpManager>(_i5.AppHttpManager());
  gh.singleton<_i7.AuthenticationRepository>(_i7.AuthenticationRepository(
      get<_i4.AuthenticationRemoteDataSource>(), get<_i5.AppHttpManager>()));
  gh.singleton<_i57.IPv6>(_i57.IPv6());
  gh.singleton<_i49.NetworkBloc>(_i49.NetworkBloc(get<_i57.IPv6>()));
  gh.singleton<_i58.UserStorage>(_i58.UserStorage());
  gh.singleton<_i32.AuthenticationBloc>(_i32.AuthenticationBloc(
      get<_i6.GetCurrentUserUseCase>(),
      get<_i28.UserSignOutUseCase>(),
      get<_i9.InitialAuthenticationUseCase>(),
      get<_i8.IdentifyUserUseCase>()));
  gh.singleton<_i59.ShareNewsBloc>(_i59.ShareNewsBloc(
      get<_i22.ShareNewsUseCase>(), get<_i24.UserEventBloc>()));
  gh.singleton<_i36.UserRepository>(
      _i36.UserRepository(get<_i58.UserStorage>()));
  gh.singleton<_i60.HistoryBloc>(
      _i60.HistoryBloc(get<_i46.GetViewNewsHistoryUseCase>()));
  gh.singleton<_i61.BlockBloc>(_i61.BlockBloc(get<_i39.GetBlocksUseCase>()));
  gh.singleton<_i62.BookmarkBloc>(
      _i62.BookmarkBloc(get<_i40.GetBookmarkUseCase>()));
  gh.singleton<_i63.LikeNewsBloc>(_i63.LikeNewsBloc(
      get<_i47.LikeNewsUseCase>(), get<_i24.UserEventBloc>()));
  gh.singleton<_i64.ManageBlockBloc>(_i64.ManageBlockBloc(
      get<_i51.SaveBlockUseCase>(), get<_i35.DeleteBlockUseCase>()));
  gh.singleton<_i65.ManageBookmarkBloc>(_i65.ManageBookmarkBloc(
      get<_i52.SaveBookmarkUseCase>(),
      get<_i24.UserEventBloc>(),
      get<_i37.DeleteBookmarkUseCase>()));
  gh.singleton<_i66.ManageHistoryBloc>(_i66.ManageHistoryBloc(
      get<_i53.SaveUserViewNewsHistoryUseCase>(),
      get<_i38.DeleteUserViewNewsHistoryUseCase>(),
      get<_i24.UserEventBloc>()));
  gh.singleton<_i67.NewsBloc>(_i67.NewsBloc(get<_i65.ManageBookmarkBloc>(),
      get<_i66.ManageHistoryBloc>(), get<_i63.LikeNewsBloc>()));
  return get;
}
