// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:flutter/widgets.dart' as _i47;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../core/IPv6.dart' as _i59;
import '../data/data_source/authentication/authentication_remote_data_source.dart'
    as _i4;
import '../data/data_source/news/news_local_data_source.dart' as _i10;
import '../data/data_source/news/news_remote_data_source.dart' as _i11;
import '../data/data_source/personalize/personalize_remote_data_source.dart'
    as _i12;
import '../data/data_source/search_item/search_item_fuse.dart' as _i13;
import '../data/data_source/search_item/search_local_data_source.dart' as _i14;
import '../data/data_source/search_item/search_remote_data_source.dart' as _i15;
import '../data/data_source/trending/trending_remote_data_source.dart' as _i23;
import '../data/data_source/user_storage/user_storage.dart' as _i60;
import '../data/http_manager/amplify_http_manager.dart' as _i3;
import '../data/http_manager/app_http_manager.dart' as _i5;
import '../data/repository/authentication_repository.dart' as _i7;
import '../data/repository/explore.repository.dart' as _i28;
import '../data/repository/news_repository.dart' as _i29;
import '../data/repository/search_repository.dart' as _i16;
import '../data/repository/user_event_repository.dart' as _i25;
import '../data/repository/user_repository.dart' as _i33;
import '../domain/use_case/delete_block_use_case.dart' as _i32;
import '../domain/use_case/delete_bookmark_use_case.dart' as _i34;
import '../domain/use_case/delete_user_view_news_history_use_case.dart' as _i35;
import '../domain/use_case/event/send_event_bookmark_news_use_case.dart'
    as _i18;
import '../domain/use_case/event/send_event_like_news_use_case.dart' as _i19;
import '../domain/use_case/event/send_event_share_news_use_case.dart' as _i20;
import '../domain/use_case/event/send_event_view_news_use_case.dart' as _i21;
import '../domain/use_case/get_blocks_use_case.dart' as _i36;
import '../domain/use_case/get_bookmark_use_case.dart' as _i37;
import '../domain/use_case/get_current_user_use_case.dart' as _i6;
import '../domain/use_case/get_explore_use_case.dart' as _i38;
import '../domain/use_case/get_news_feed_trend_use_case.dart' as _i39;
import '../domain/use_case/get_news_feed_use_case.dart' as _i40;
import '../domain/use_case/get_personalize_latest_news_use_case.dart' as _i41;
import '../domain/use_case/get_recommendation_use_case.dart' as _i42;
import '../domain/use_case/get_suggestion_use_case.dart' as _i43;
import '../domain/use_case/get_view_news_history_use_case.dart' as _i44;
import '../domain/use_case/identify_user_use_case.dart' as _i8;
import '../domain/use_case/initial_authentication_use_case.dart' as _i9;
import '../domain/use_case/like_news_use_case.dart' as _i45;
import '../domain/use_case/save_block_use_case.dart' as _i52;
import '../domain/use_case/save_bookmark_use_case.dart' as _i53;
import '../domain/use_case/save_user_view_news_history_use_case.dart' as _i54;
import '../domain/use_case/search_use_case.dart' as _i17;
import '../domain/use_case/share_news_use_case.dart' as _i22;
import '../domain/use_case/user_signin_with_amplify_use_case.dart' as _i26;
import '../domain/use_case/user_signin_with_authcode_use_case.dart' as _i27;
import '../domain/use_case/user_signout_use_case.dart' as _i31;
import '../presentation/bloc/authentication/authentication_bloc.dart' as _i48;
import '../presentation/bloc/block/block_bloc.dart' as _i63;
import '../presentation/bloc/bookmark/bookmark_bloc.dart' as _i64;
import '../presentation/bloc/explore/explore_bloc.dart' as _i57;
import '../presentation/bloc/feed/feed_bloc.dart' as _i58;
import '../presentation/bloc/history/history_bloc.dart' as _i62;
import '../presentation/bloc/like_news/like_news_bloc.dart' as _i65;
import '../presentation/bloc/manage_block/manage_block_bloc.dart' as _i66;
import '../presentation/bloc/manage_bookmark/manage_bookmark_bloc.dart' as _i67;
import '../presentation/bloc/manage_history/manage_history_bloc.dart' as _i68;
import '../presentation/bloc/navigation/navigation_bloc.dart' as _i46;
import '../presentation/bloc/network/network_bloc.dart' as _i50;
import '../presentation/bloc/news/news_bloc.dart' as _i69;
import '../presentation/bloc/query/query_bloc.dart' as _i49;
import '../presentation/bloc/recommendation/recommendation_bloc.dart' as _i51;
import '../presentation/bloc/search/search_bloc.dart' as _i30;
import '../presentation/bloc/share_news/share_news_bloc.dart' as _i61;
import '../presentation/bloc/signin/signin_bloc.dart' as _i55;
import '../presentation/bloc/suggest/suggest_bloc.dart' as _i56;
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
  gh.factory<_i12.PersonalizeRemoteDataSource>(
      () => _i12.PersonalizeRemoteDataSource(get<_i3.AmplifyHttpManager>()));
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
  gh.factory<_i28.ExploreRepository>(
      () => _i28.ExploreRepository(get<_i23.TrendingRemoteDataSource>()));
  gh.factory<_i29.NewsRepository>(() => _i29.NewsRepository(
      get<_i11.NewsRemoteDataSource>(),
      get<_i10.NewsLocalDataSource>(),
      get<_i12.PersonalizeRemoteDataSource>()));
  gh.factory<_i30.SearchBloc>(() => _i30.SearchBloc(get<_i17.SearchUseCase>()));
  gh.factory<_i31.UserSignOutUseCase>(() => _i31.UserSignOutUseCase(
      get<_i7.AuthenticationRepository>(), get<_i29.NewsRepository>()));
  gh.factory<_i32.DeleteBlockUseCase>(() => _i32.DeleteBlockUseCase(
      get<_i7.AuthenticationRepository>(), get<_i33.UserRepository>()));
  gh.factory<_i34.DeleteBookmarkUseCase>(() => _i34.DeleteBookmarkUseCase(
      get<_i7.AuthenticationRepository>(), get<_i33.UserRepository>()));
  gh.factory<_i35.DeleteUserViewNewsHistoryUseCase>(() =>
      _i35.DeleteUserViewNewsHistoryUseCase(
          get<_i7.AuthenticationRepository>(), get<_i33.UserRepository>()));
  gh.factory<_i36.GetBlocksUseCase>(() => _i36.GetBlocksUseCase(
      get<_i7.AuthenticationRepository>(), get<_i33.UserRepository>()));
  gh.factory<_i37.GetBookmarkUseCase>(() => _i37.GetBookmarkUseCase(
      get<_i7.AuthenticationRepository>(),
      get<_i33.UserRepository>(),
      get<_i29.NewsRepository>()));
  gh.factory<_i38.GetExploreUseCase>(() => _i38.GetExploreUseCase(
      get<_i28.ExploreRepository>(),
      get<_i33.UserRepository>(),
      get<_i7.AuthenticationRepository>()));
  gh.factory<_i39.GetNewsFeedTrendUseCase>(() => _i39.GetNewsFeedTrendUseCase(
      get<_i29.NewsRepository>(),
      get<_i33.UserRepository>(),
      get<_i7.AuthenticationRepository>()));
  gh.factory<_i40.GetNewsFeedUseCase>(() => _i40.GetNewsFeedUseCase(
      get<_i29.NewsRepository>(),
      get<_i33.UserRepository>(),
      get<_i7.AuthenticationRepository>()));
  gh.factory<_i41.GetPersonalizeLatestNewsUseCase>(() =>
      _i41.GetPersonalizeLatestNewsUseCase(get<_i29.NewsRepository>(),
          get<_i33.UserRepository>(), get<_i7.AuthenticationRepository>()));
  gh.factory<_i42.GetRecommendationsUseCase>(() =>
      _i42.GetRecommendationsUseCase(get<_i29.NewsRepository>(),
          get<_i33.UserRepository>(), get<_i7.AuthenticationRepository>()));
  gh.factory<_i43.GetSuggestionNewsUseCase>(() => _i43.GetSuggestionNewsUseCase(
      get<_i29.NewsRepository>(),
      get<_i33.UserRepository>(),
      get<_i7.AuthenticationRepository>()));
  gh.factory<_i44.GetViewNewsHistoryUseCase>(() =>
      _i44.GetViewNewsHistoryUseCase(get<_i7.AuthenticationRepository>(),
          get<_i33.UserRepository>(), get<_i29.NewsRepository>()));
  gh.factory<_i45.LikeNewsUseCase>(() => _i45.LikeNewsUseCase(
      get<_i7.AuthenticationRepository>(), get<_i33.UserRepository>()));
  gh.factoryParam<_i46.NavigationBloc, _i47.PageController, dynamic>(
      (pageController, _) =>
          _i46.NavigationBloc(pageController, get<_i48.AuthenticationBloc>()));
  gh.factory<_i49.QueryFeedBloc>(() => _i49.QueryFeedBloc(
      get<_i40.GetNewsFeedUseCase>(),
      get<_i39.GetNewsFeedTrendUseCase>(),
      get<_i50.NetworkBloc>()));
  gh.factory<_i51.RecommendationBloc>(() => _i51.RecommendationBloc(
      get<_i42.GetRecommendationsUseCase>(), get<_i50.NetworkBloc>()));
  gh.factory<_i52.SaveBlockUseCase>(() => _i52.SaveBlockUseCase(
      get<_i7.AuthenticationRepository>(), get<_i33.UserRepository>()));
  gh.factory<_i53.SaveBookmarkUseCase>(() => _i53.SaveBookmarkUseCase(
      get<_i7.AuthenticationRepository>(), get<_i33.UserRepository>()));
  gh.factory<_i54.SaveUserViewNewsHistoryUseCase>(() =>
      _i54.SaveUserViewNewsHistoryUseCase(
          get<_i7.AuthenticationRepository>(), get<_i33.UserRepository>()));
  gh.factory<_i55.SigninBloc>(() => _i55.SigninBloc(
      get<_i48.AuthenticationBloc>(),
      get<_i26.UserSignInWithAmplifyUseCase>(),
      get<_i8.IdentifyUserUseCase>()));
  gh.factory<_i56.SuggestFeedBloc>(() => _i56.SuggestFeedBloc(
      get<_i43.GetSuggestionNewsUseCase>(), get<_i50.NetworkBloc>()));
  gh.factory<_i57.ExploreBloc>(
      () => _i57.ExploreBloc(get<_i38.GetExploreUseCase>()));
  gh.factory<_i58.FeedBloc>(() => _i58.FeedBloc(
      get<_i41.GetPersonalizeLatestNewsUseCase>(), get<_i50.NetworkBloc>()));
  gh.singleton<_i5.AppHttpManager>(_i5.AppHttpManager());
  gh.singleton<_i7.AuthenticationRepository>(_i7.AuthenticationRepository(
      get<_i4.AuthenticationRemoteDataSource>(), get<_i5.AppHttpManager>()));
  gh.singleton<_i59.IPv6>(_i59.IPv6());
  gh.singleton<_i50.NetworkBloc>(_i50.NetworkBloc(get<_i59.IPv6>()));
  gh.singleton<_i60.UserStorage>(_i60.UserStorage());
  gh.singleton<_i61.ShareNewsBloc>(_i61.ShareNewsBloc(
      get<_i22.ShareNewsUseCase>(), get<_i24.UserEventBloc>()));
  gh.singleton<_i33.UserRepository>(
      _i33.UserRepository(get<_i60.UserStorage>()));
  gh.singleton<_i48.AuthenticationBloc>(_i48.AuthenticationBloc(
      get<_i6.GetCurrentUserUseCase>(),
      get<_i31.UserSignOutUseCase>(),
      get<_i9.InitialAuthenticationUseCase>(),
      get<_i8.IdentifyUserUseCase>()));
  gh.singleton<_i62.HistoryBloc>(
      _i62.HistoryBloc(get<_i44.GetViewNewsHistoryUseCase>()));
  gh.singleton<_i63.BlockBloc>(_i63.BlockBloc(get<_i36.GetBlocksUseCase>()));
  gh.singleton<_i64.BookmarkBloc>(
      _i64.BookmarkBloc(get<_i37.GetBookmarkUseCase>()));
  gh.singleton<_i65.LikeNewsBloc>(_i65.LikeNewsBloc(
      get<_i45.LikeNewsUseCase>(), get<_i24.UserEventBloc>()));
  gh.singleton<_i66.ManageBlockBloc>(_i66.ManageBlockBloc(
      get<_i52.SaveBlockUseCase>(), get<_i32.DeleteBlockUseCase>()));
  gh.singleton<_i67.ManageBookmarkBloc>(_i67.ManageBookmarkBloc(
      get<_i53.SaveBookmarkUseCase>(),
      get<_i24.UserEventBloc>(),
      get<_i34.DeleteBookmarkUseCase>()));
  gh.singleton<_i68.ManageHistoryBloc>(_i68.ManageHistoryBloc(
      get<_i54.SaveUserViewNewsHistoryUseCase>(),
      get<_i35.DeleteUserViewNewsHistoryUseCase>(),
      get<_i24.UserEventBloc>()));
  gh.singleton<_i69.NewsBloc>(_i69.NewsBloc(get<_i67.ManageBookmarkBloc>(),
      get<_i68.ManageHistoryBloc>(), get<_i65.LikeNewsBloc>()));
  return get;
}
