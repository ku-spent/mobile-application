// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../core/IPv6.dart' as _i64;
import '../data/data_source/authentication/authentication_remote_data_source.dart'
    as _i4;
import '../data/data_source/following/following_remote_data_source.dart' as _i6;
import '../data/data_source/news/news_local_data_source.dart' as _i11;
import '../data/data_source/news/news_remote_data_source.dart' as _i12;
import '../data/data_source/personalize/personalize_remote_data_source.dart'
    as _i13;
import '../data/data_source/search_item/search_item_fuse.dart' as _i14;
import '../data/data_source/search_item/search_local_data_source.dart' as _i15;
import '../data/data_source/search_item/search_remote_data_source.dart' as _i16;
import '../data/data_source/trending/trending_remote_data_source.dart' as _i24;
import '../data/data_source/user_storage/user_storage.dart' as _i65;
import '../data/http_manager/amplify_http_manager.dart' as _i3;
import '../data/http_manager/app_http_manager.dart' as _i5;
import '../data/repository/authentication_repository.dart' as _i8;
import '../data/repository/explore.repository.dart' as _i28;
import '../data/repository/news_repository.dart' as _i29;
import '../data/repository/search_repository.dart' as _i17;
import '../data/repository/user_event_repository.dart' as _i26;
import '../data/repository/user_repository.dart' as _i33;
import '../domain/use_case/add_following_use_case.dart' as _i32;
import '../domain/use_case/delete_block_use_case.dart' as _i34;
import '../domain/use_case/delete_bookmark_use_case.dart' as _i35;
import '../domain/use_case/delete_following_use_case.dart' as _i36;
import '../domain/use_case/delete_user_view_news_history_use_case.dart' as _i37;
import '../domain/use_case/event/send_event_bookmark_news_use_case.dart'
    as _i19;
import '../domain/use_case/event/send_event_like_news_use_case.dart' as _i20;
import '../domain/use_case/event/send_event_share_news_use_case.dart' as _i21;
import '../domain/use_case/event/send_event_view_news_use_case.dart' as _i22;
import '../domain/use_case/get_blocks_use_case.dart' as _i38;
import '../domain/use_case/get_bookmark_use_case.dart' as _i39;
import '../domain/use_case/get_current_user_use_case.dart' as _i7;
import '../domain/use_case/get_explore_use_case.dart' as _i40;
import '../domain/use_case/get_following_list_use_case.dart' as _i42;
import '../domain/use_case/get_following_name_use_case.dart' as _i41;
import '../domain/use_case/get_news_feed_trend_use_case.dart' as _i43;
import '../domain/use_case/get_news_feed_use_case.dart' as _i44;
import '../domain/use_case/get_personalize_latest_news_use_case.dart' as _i45;
import '../domain/use_case/get_recommendation_use_case.dart' as _i46;
import '../domain/use_case/get_suggestion_use_case.dart' as _i47;
import '../domain/use_case/get_view_news_history_use_case.dart' as _i48;
import '../domain/use_case/identify_user_use_case.dart' as _i9;
import '../domain/use_case/initial_authentication_use_case.dart' as _i10;
import '../domain/use_case/like_news_use_case.dart' as _i49;
import '../domain/use_case/save_block_use_case.dart' as _i53;
import '../domain/use_case/save_bookmark_use_case.dart' as _i54;
import '../domain/use_case/save_following_list_use_case.dart' as _i55;
import '../domain/use_case/save_user_view_news_history_use_case.dart' as _i56;
import '../domain/use_case/search_use_case.dart' as _i18;
import '../domain/use_case/share_news_use_case.dart' as _i23;
import '../domain/use_case/user_signin_with_amplify_use_case.dart' as _i27;
import '../domain/use_case/user_signout_use_case.dart' as _i31;
import '../presentation/bloc/authentication/authentication_bloc.dart' as _i58;
import '../presentation/bloc/block/block_bloc.dart' as _i68;
import '../presentation/bloc/bookmark/bookmark_bloc.dart' as _i69;
import '../presentation/bloc/explore/explore_bloc.dart' as _i60;
import '../presentation/bloc/feed/feed_bloc.dart' as _i61;
import '../presentation/bloc/following/following_bloc.dart' as _i62;
import '../presentation/bloc/history/history_bloc.dart' as _i67;
import '../presentation/bloc/like_news/like_news_bloc.dart' as _i70;
import '../presentation/bloc/manage_block/manage_block_bloc.dart' as _i71;
import '../presentation/bloc/manage_bookmark/manage_bookmark_bloc.dart' as _i72;
import '../presentation/bloc/manage_following/manage_following_bloc.dart'
    as _i63;
import '../presentation/bloc/manage_history/manage_history_bloc.dart' as _i73;
import '../presentation/bloc/network/network_bloc.dart' as _i51;
import '../presentation/bloc/news/news_bloc.dart' as _i74;
import '../presentation/bloc/query/query_bloc.dart' as _i50;
import '../presentation/bloc/recommendation/recommendation_bloc.dart' as _i52;
import '../presentation/bloc/search/search_bloc.dart' as _i30;
import '../presentation/bloc/share_news/share_news_bloc.dart' as _i66;
import '../presentation/bloc/signin/signin_bloc.dart' as _i57;
import '../presentation/bloc/suggest/suggest_bloc.dart' as _i59;
import '../presentation/bloc/user_event/user_event_bloc.dart'
    as _i25; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(_i1.GetIt get,
    {String environment, _i2.EnvironmentFilter environmentFilter}) {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  gh.factory<_i3.AmplifyHttpManager>(() => _i3.AmplifyHttpManager());
  gh.factory<_i4.AuthenticationRemoteDataSource>(
      () => _i4.AuthenticationRemoteDataSource(get<_i5.AppHttpManager>()));
  gh.factory<_i6.FollowingRemoteDataSource>(
      () => _i6.FollowingRemoteDataSource(get<_i3.AmplifyHttpManager>()));
  gh.factory<_i7.GetCurrentUserUseCase>(
      () => _i7.GetCurrentUserUseCase(get<_i8.AuthenticationRepository>()));
  gh.factory<_i9.IdentifyUserUseCase>(
      () => _i9.IdentifyUserUseCase(get<_i8.AuthenticationRepository>()));
  gh.factory<_i10.InitialAuthenticationUseCase>(() =>
      _i10.InitialAuthenticationUseCase(get<_i8.AuthenticationRepository>()));
  gh.factory<_i11.NewsLocalDataSource>(() => _i11.NewsLocalDataSource());
  gh.factory<_i12.NewsRemoteDataSource>(
      () => _i12.NewsRemoteDataSource(get<_i3.AmplifyHttpManager>()));
  gh.factory<_i13.PersonalizeRemoteDataSource>(
      () => _i13.PersonalizeRemoteDataSource(get<_i3.AmplifyHttpManager>()));
  gh.factory<_i14.SearchItemFuse>(() => _i14.SearchItemFuse());
  gh.factory<_i15.SearchLocalDataSource>(
      () => _i15.SearchLocalDataSource(get<_i14.SearchItemFuse>()));
  gh.factory<_i16.SearchRemoteDataSource>(
      () => _i16.SearchRemoteDataSource(get<_i3.AmplifyHttpManager>()));
  gh.factory<_i17.SearchRepository>(() => _i17.SearchRepository(
      get<_i16.SearchRemoteDataSource>(), get<_i15.SearchLocalDataSource>()));
  gh.factory<_i18.SearchUseCase>(
      () => _i18.SearchUseCase(get<_i17.SearchRepository>()));
  gh.factory<_i19.SendEventBookmarkNewsUseCase>(
      () => _i19.SendEventBookmarkNewsUseCase());
  gh.factory<_i20.SendEventLikeNewsUseCase>(
      () => _i20.SendEventLikeNewsUseCase());
  gh.factory<_i21.SendEventShareNewsUseCase>(
      () => _i21.SendEventShareNewsUseCase());
  gh.factory<_i22.SendEventViewNewsUseCase>(
      () => _i22.SendEventViewNewsUseCase());
  gh.factory<_i23.ShareNewsUseCase>(() => _i23.ShareNewsUseCase());
  gh.factory<_i24.TrendingRemoteDataSource>(
      () => _i24.TrendingRemoteDataSource(get<_i3.AmplifyHttpManager>()));
  gh.factory<_i25.UserEventBloc>(() => _i25.UserEventBloc(
      get<_i22.SendEventViewNewsUseCase>(),
      get<_i19.SendEventBookmarkNewsUseCase>(),
      get<_i20.SendEventLikeNewsUseCase>(),
      get<_i21.SendEventShareNewsUseCase>()));
  gh.factory<_i26.UserEventRepository>(() => _i26.UserEventRepository());
  gh.factory<_i27.UserSignInWithAmplifyUseCase>(() =>
      _i27.UserSignInWithAmplifyUseCase(get<_i8.AuthenticationRepository>()));
  gh.factory<_i28.ExploreRepository>(
      () => _i28.ExploreRepository(get<_i24.TrendingRemoteDataSource>()));
  gh.factory<_i29.NewsRepository>(() => _i29.NewsRepository(
      get<_i12.NewsRemoteDataSource>(),
      get<_i11.NewsLocalDataSource>(),
      get<_i13.PersonalizeRemoteDataSource>()));
  gh.factory<_i30.SearchBloc>(() => _i30.SearchBloc(get<_i18.SearchUseCase>()));
  gh.factory<_i31.UserSignOutUseCase>(() => _i31.UserSignOutUseCase(
      get<_i8.AuthenticationRepository>(), get<_i29.NewsRepository>()));
  gh.factory<_i32.AddFollowingUseCase>(() => _i32.AddFollowingUseCase(
      get<_i33.UserRepository>(), get<_i8.AuthenticationRepository>()));
  gh.factory<_i34.DeleteBlockUseCase>(() => _i34.DeleteBlockUseCase(
      get<_i8.AuthenticationRepository>(), get<_i33.UserRepository>()));
  gh.factory<_i35.DeleteBookmarkUseCase>(() => _i35.DeleteBookmarkUseCase(
      get<_i8.AuthenticationRepository>(), get<_i33.UserRepository>()));
  gh.factory<_i36.DeleteFollowingUseCase>(() => _i36.DeleteFollowingUseCase(
      get<_i33.UserRepository>(), get<_i8.AuthenticationRepository>()));
  gh.factory<_i37.DeleteUserViewNewsHistoryUseCase>(() =>
      _i37.DeleteUserViewNewsHistoryUseCase(
          get<_i8.AuthenticationRepository>(), get<_i33.UserRepository>()));
  gh.factory<_i38.GetBlocksUseCase>(() => _i38.GetBlocksUseCase(
      get<_i8.AuthenticationRepository>(), get<_i33.UserRepository>()));
  gh.factory<_i39.GetBookmarkUseCase>(() => _i39.GetBookmarkUseCase(
      get<_i8.AuthenticationRepository>(),
      get<_i33.UserRepository>(),
      get<_i29.NewsRepository>()));
  gh.factory<_i40.GetExploreUseCase>(() => _i40.GetExploreUseCase(
      get<_i28.ExploreRepository>(),
      get<_i33.UserRepository>(),
      get<_i8.AuthenticationRepository>()));
  gh.factory<_i41.GetFollowingByNameUseCase>(() =>
      _i41.GetFollowingByNameUseCase(
          get<_i33.UserRepository>(), get<_i8.AuthenticationRepository>()));
  gh.factory<_i42.GetFollowingListUseCase>(() => _i42.GetFollowingListUseCase(
      get<_i33.UserRepository>(), get<_i8.AuthenticationRepository>()));
  gh.factory<_i43.GetNewsFeedTrendUseCase>(() => _i43.GetNewsFeedTrendUseCase(
      get<_i29.NewsRepository>(),
      get<_i33.UserRepository>(),
      get<_i8.AuthenticationRepository>()));
  gh.factory<_i44.GetNewsFeedUseCase>(() => _i44.GetNewsFeedUseCase(
      get<_i29.NewsRepository>(),
      get<_i33.UserRepository>(),
      get<_i8.AuthenticationRepository>()));
  gh.factory<_i45.GetPersonalizeLatestNewsUseCase>(() =>
      _i45.GetPersonalizeLatestNewsUseCase(get<_i29.NewsRepository>(),
          get<_i33.UserRepository>(), get<_i8.AuthenticationRepository>()));
  gh.factory<_i46.GetRecommendationsUseCase>(() =>
      _i46.GetRecommendationsUseCase(get<_i29.NewsRepository>(),
          get<_i33.UserRepository>(), get<_i8.AuthenticationRepository>()));
  gh.factory<_i47.GetSuggestionNewsUseCase>(() => _i47.GetSuggestionNewsUseCase(
      get<_i29.NewsRepository>(),
      get<_i33.UserRepository>(),
      get<_i8.AuthenticationRepository>()));
  gh.factory<_i48.GetViewNewsHistoryUseCase>(() =>
      _i48.GetViewNewsHistoryUseCase(get<_i8.AuthenticationRepository>(),
          get<_i33.UserRepository>(), get<_i29.NewsRepository>()));
  gh.factory<_i49.LikeNewsUseCase>(() => _i49.LikeNewsUseCase(
      get<_i8.AuthenticationRepository>(), get<_i33.UserRepository>()));
  gh.factory<_i50.QueryFeedBloc>(() => _i50.QueryFeedBloc(
      get<_i44.GetNewsFeedUseCase>(),
      get<_i43.GetNewsFeedTrendUseCase>(),
      get<_i51.NetworkBloc>()));
  gh.factory<_i52.RecommendationBloc>(() => _i52.RecommendationBloc(
      get<_i46.GetRecommendationsUseCase>(), get<_i51.NetworkBloc>()));
  gh.factory<_i53.SaveBlockUseCase>(() => _i53.SaveBlockUseCase(
      get<_i8.AuthenticationRepository>(), get<_i33.UserRepository>()));
  gh.factory<_i54.SaveBookmarkUseCase>(() => _i54.SaveBookmarkUseCase(
      get<_i8.AuthenticationRepository>(), get<_i33.UserRepository>()));
  gh.factory<_i55.SaveFollowingListUseCase>(() => _i55.SaveFollowingListUseCase(
      get<_i33.UserRepository>(), get<_i8.AuthenticationRepository>()));
  gh.factory<_i56.SaveUserViewNewsHistoryUseCase>(() =>
      _i56.SaveUserViewNewsHistoryUseCase(
          get<_i8.AuthenticationRepository>(), get<_i33.UserRepository>()));
  gh.factory<_i57.SigninBloc>(() => _i57.SigninBloc(
      get<_i58.AuthenticationBloc>(),
      get<_i27.UserSignInWithAmplifyUseCase>(),
      get<_i9.IdentifyUserUseCase>()));
  gh.factory<_i59.SuggestFeedBloc>(() => _i59.SuggestFeedBloc(
      get<_i47.GetSuggestionNewsUseCase>(), get<_i51.NetworkBloc>()));
  gh.factory<_i60.ExploreBloc>(
      () => _i60.ExploreBloc(get<_i40.GetExploreUseCase>()));
  gh.factory<_i61.FeedBloc>(() => _i61.FeedBloc(
      get<_i45.GetPersonalizeLatestNewsUseCase>(), get<_i51.NetworkBloc>()));
  gh.factory<_i62.FollowingBloc>(() => _i62.FollowingBloc(
      get<_i42.GetFollowingListUseCase>(),
      get<_i41.GetFollowingByNameUseCase>()));
  gh.factory<_i63.ManageFollowingBloc>(() => _i63.ManageFollowingBloc(
      get<_i36.DeleteFollowingUseCase>(),
      get<_i32.AddFollowingUseCase>(),
      get<_i55.SaveFollowingListUseCase>()));
  gh.singleton<_i5.AppHttpManager>(_i5.AppHttpManager());
  gh.singleton<_i8.AuthenticationRepository>(
      _i8.AuthenticationRepository(get<_i4.AuthenticationRemoteDataSource>()));
  gh.singleton<_i64.IPv6>(_i64.IPv6());
  gh.singleton<_i51.NetworkBloc>(_i51.NetworkBloc(get<_i64.IPv6>()));
  gh.singleton<_i65.UserStorage>(_i65.UserStorage());
  gh.singleton<_i66.ShareNewsBloc>(_i66.ShareNewsBloc(
      get<_i23.ShareNewsUseCase>(), get<_i25.UserEventBloc>()));
  gh.singleton<_i33.UserRepository>(_i33.UserRepository(
      get<_i65.UserStorage>(), get<_i6.FollowingRemoteDataSource>()));
  gh.singleton<_i58.AuthenticationBloc>(_i58.AuthenticationBloc(
      get<_i7.GetCurrentUserUseCase>(),
      get<_i31.UserSignOutUseCase>(),
      get<_i10.InitialAuthenticationUseCase>(),
      get<_i9.IdentifyUserUseCase>()));
  gh.singleton<_i67.HistoryBloc>(
      _i67.HistoryBloc(get<_i48.GetViewNewsHistoryUseCase>()));
  gh.singleton<_i68.BlockBloc>(_i68.BlockBloc(get<_i38.GetBlocksUseCase>()));
  gh.singleton<_i69.BookmarkBloc>(
      _i69.BookmarkBloc(get<_i39.GetBookmarkUseCase>()));
  gh.singleton<_i70.LikeNewsBloc>(_i70.LikeNewsBloc(
      get<_i49.LikeNewsUseCase>(), get<_i25.UserEventBloc>()));
  gh.singleton<_i71.ManageBlockBloc>(_i71.ManageBlockBloc(
      get<_i53.SaveBlockUseCase>(), get<_i34.DeleteBlockUseCase>()));
  gh.singleton<_i72.ManageBookmarkBloc>(_i72.ManageBookmarkBloc(
      get<_i54.SaveBookmarkUseCase>(),
      get<_i25.UserEventBloc>(),
      get<_i35.DeleteBookmarkUseCase>()));
  gh.singleton<_i73.ManageHistoryBloc>(_i73.ManageHistoryBloc(
      get<_i56.SaveUserViewNewsHistoryUseCase>(),
      get<_i37.DeleteUserViewNewsHistoryUseCase>(),
      get<_i25.UserEventBloc>()));
  gh.singleton<_i74.NewsBloc>(_i74.NewsBloc(get<_i72.ManageBookmarkBloc>(),
      get<_i73.ManageHistoryBloc>(), get<_i70.LikeNewsBloc>()));
  return get;
}
