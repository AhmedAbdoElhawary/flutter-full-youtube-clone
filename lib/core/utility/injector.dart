import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:youtube/data/data_sources/local/channnel/interfaces/cache_channel_apis.dart';
import 'package:youtube/data/data_sources/local/channnel/interfaces/cache_channel_playlist_apis.dart';
import 'package:youtube/data/data_sources/local/channnel/interfaces/cache_channel_videos_apis.dart';
import 'package:youtube/data/data_sources/local/videos/interfaces/cache_videos_apis.dart';
import 'package:youtube/data/data_sources/remote/api/channel/channel_apis.dart';
import 'package:youtube/data/data_sources/remote/api/channel/channel_playlist/channel_playlist_apis.dart';
import 'package:youtube/data/data_sources/remote/api/channel/channel_videos/channel_videos_apis.dart';
import 'package:youtube/data/data_sources/remote/api/search/auto_complete_search/auto_complete_text_apis.dart';
import 'package:youtube/data/data_sources/remote/api/search/search_apis.dart';
import 'package:youtube/data/data_sources/remote/api/single_video/commet/comment_apis.dart';
import 'package:youtube/data/data_sources/remote/api/single_video/single_video_apis.dart';
import 'package:youtube/data/data_sources/remote/api/videos/videos_apis.dart';
import 'package:youtube/data/repositories_impl/channel/channel_details_repo_impl.dart';
import 'package:youtube/data/repositories_impl/channel/channel_videos_repo_impl.dart';
import 'package:youtube/data/repositories_impl/search_details_repo_impl.dart';
import 'package:youtube/data/repositories_impl/single_video_details/single_video_details_repo_impl.dart';
import 'package:youtube/data/repositories_impl/single_video_details/video_comment_details_repo_impl.dart';
import 'package:youtube/data/repositories_impl/videos_details_repo_impl.dart';
import 'package:youtube/domain/repositories/channel/channel_details_repository.dart';
import 'package:youtube/domain/repositories/channel/channel_videos_repository.dart';
import 'package:youtube/domain/repositories/search_details_repository.dart';
import 'package:youtube/domain/repositories/video_comment_details/single_video_details_repository.dart';
import 'package:youtube/domain/repositories/video_comment_details/video_comment_details_repositroy.dart';
import 'package:youtube/domain/repositories/videos_details_repository.dart';
import 'package:youtube/domain/use_cases/channel/channel_details/channel_sub_details_use_case.dart';
import 'package:youtube/domain/use_cases/channel/channel_details/clear/clear_my_subscriptions_channels_use_case.dart';
import 'package:youtube/domain/use_cases/channel/channel_details/delete_subscription_use_case.dart';
import 'package:youtube/domain/use_cases/channel/channel_details/get_videos_of_those_channels_use_case.dart';
import 'package:youtube/domain/use_cases/channel/channel_details/my_subscriptions_channels_use_case.dart';
import 'package:youtube/domain/use_cases/channel/channel_details/subscribe_to_channel_use_case.dart';
import 'package:youtube/domain/use_cases/channel/channel_videos/channel_popular_videos_use_case.dart';
import 'package:youtube/domain/use_cases/channel/channel_videos/channel_short_poupal_videos_use_case.dart';
import 'package:youtube/domain/use_cases/channel/channel_videos/channel_short_videos_use_case.dart';
import 'package:youtube/domain/use_cases/channel/channel_videos/channel_videos_use_case.dart';
import 'package:youtube/domain/use_cases/channel/channel_videos/clear/clear_all_channel_short_videos_use_case.dart';
import 'package:youtube/domain/use_cases/channel/channel_videos/clear/clear_all_channel_videos_use_case.dart';
import 'package:youtube/domain/use_cases/channel/channel_videos/clear/clear_all_popular_channel_short_videos_use_case.dart';
import 'package:youtube/domain/use_cases/channel/channel_videos/clear/clear_all_popular_channel_videos_use_case.dart';
import 'package:youtube/domain/use_cases/channel/channel_videos/clear/clear_videos_of_those_channels_use_case.dart';
import 'package:youtube/domain/use_cases/channel/playlist/channel_playlist_items_use_case.dart';
import 'package:youtube/domain/use_cases/channel/playlist/channel_playlists_use_case.dart';
import 'package:youtube/domain/use_cases/channel/playlist/clear/clear_channel_playlists_use_case.dart';
import 'package:youtube/domain/use_cases/search_details/related_videos_to_this_video_use_case.dart';
import 'package:youtube/domain/use_cases/search_details/search_for_this_sentence_use_case.dart';
import 'package:youtube/domain/use_cases/search_details/suggestion_search_texts_use_case.dart';
import 'package:youtube/domain/use_cases/single_video/comment/get_all_comments_use_case.dart';
import 'package:youtube/domain/use_cases/single_video/comment/get_all_replies_use_case.dart';
import 'package:youtube/domain/use_cases/single_video/comment/get_first_comment_use_case.dart';
import 'package:youtube/domain/use_cases/single_video/get_video_details_use_case.dart';
import 'package:youtube/domain/use_cases/single_video/get_video_rating_use_case.dart';
import 'package:youtube/domain/use_cases/single_video/rate_video_use_case.dart';
import 'package:youtube/domain/use_cases/videos_details/all_short_videos_use_case.dart';
import 'package:youtube/domain/use_cases/videos_details/all_videos_use_case.dart';
import 'package:youtube/domain/use_cases/videos_details/clear/clear_all_short_videos_use_case.dart';
import 'package:youtube/domain/use_cases/videos_details/clear/clear_all_videos_use_case.dart';
import 'package:youtube/domain/use_cases/videos_details/clear/clear_most_popular_videos_use_case.dart';
import 'package:youtube/domain/use_cases/videos_details/most_popular_videos_use_case.dart';
import 'package:youtube/presentation/cubit/channel/channel_details_cubit.dart';
import 'package:youtube/presentation/cubit/channel/channel_videos/channel_videos_cubit.dart';
import 'package:youtube/presentation/cubit/channel/playlist/play_list_cubit.dart';
import 'package:youtube/presentation/cubit/search/search_cubit.dart';
import 'package:youtube/presentation/cubit/single_video/single_video_cubit.dart';
import 'package:youtube/presentation/cubit/videos/popular_videos/popular_videos_cubit.dart';
import 'package:youtube/presentation/cubit/videos/videos_details_cubit.dart';

final injector = GetIt.I;

Future<void> initializeDependencies() async {
  /// ===============================Local Data source =========================================>
  injector.registerLazySingleton<CacheChannelVideosAPIs>(
    () => CacheChannelVideosAPIsImpl(),
  );
  injector.registerLazySingleton<CacheChannelPlaylistAPIs>(
    () => CacheChannelPlaylistAPIsImpl(),
  );
  injector.registerLazySingleton<CacheChannelAPIs>(
    () => CacheChannelAPIsImpl(),
  );

  injector.registerLazySingleton<CacheVideosAPIs>(
    () => CacheVideosAPIsImpl(),
  );

  /// =============================== Data source =========================================>

  injector
      .registerLazySingleton<VideosAPIs>(() => VideosAPIs(createAndSetupDio()));

  injector.registerLazySingleton<ChannelAPIs>(
      () => ChannelAPIs(createAndSetupDio()));

  injector.registerLazySingleton<SingleVideosAPIs>(
      () => SingleVideosAPIs(createAndSetupDio()));

  injector
      .registerLazySingleton<SearchAPIs>(() => SearchAPIs(createAndSetupDio()));

  injector.registerLazySingleton<ChannelPlayListAPIs>(
      () => ChannelPlayListAPIs(createAndSetupDio()));

  injector.registerLazySingleton<CommentAPIs>(
      () => CommentAPIs(createAndSetupDio()));

  injector.registerLazySingleton<ChannelVideosAPIs>(
      () => ChannelVideosAPIs(createAndSetupDio()));

  injector.registerLazySingleton<SuggestionSearchTextAPIs>(
      () => SuggestionSearchTextAPIs(createAndSetupDio()));

  /// =============================== Repository =========================================>

  // videos details Repository

  injector.registerLazySingleton<VideosDetailsRepository>(
    () => VideosDetailsRepoImpl(injector(), injector(), injector()),
  );
  injector.registerLazySingleton<ChannelDetailsRepository>(
    () => ChannelDetailsRepoImpl(injector(), injector()),
  );
  injector.registerLazySingleton<VideoCommentDetailsRepository>(
    () => VideoCommentDetailsRepoImpl(injector()),
  );

  injector.registerLazySingleton<SingleVideoDetailsRepository>(
    () => SingleVideosDetailsRepoImpl(injector(), injector()),
  );
  injector.registerLazySingleton<ChannelVideosDetailsRepository>(
    () => ChannelVideosDetailsRepoImpl(injector(), injector(), injector()),
  );
  injector.registerLazySingleton<SearchDetailsRepository>(
    () => SearchDetailsRepoImpl(injector(), injector(), injector()),
  );

  // *
  /// ================================ Use cases ========================================>

  injector.registerLazySingleton<VideoDetailsUseCase>(
    () => VideoDetailsUseCase(injector()),
  );
  injector.registerLazySingleton<MySubscriptionsChannelsUseCase>(
    () => MySubscriptionsChannelsUseCase(injector()),
  );

  injector.registerLazySingleton<MostPopularVideosUseCase>(
    () => MostPopularVideosUseCase(injector()),
  );

  injector.registerLazySingleton<ChannelSubDetailsUseCase>(
    () => ChannelSubDetailsUseCase(injector()),
  );

  injector.registerLazySingleton<ChannelPopularVideosUseCase>(
    () => ChannelPopularVideosUseCase(injector()),
  );

  injector.registerLazySingleton<ChannelShortPopularVideosUseCase>(
    () => ChannelShortPopularVideosUseCase(injector()),
  );

  injector.registerLazySingleton<ChannelShortVideosUseCase>(
    () => ChannelShortVideosUseCase(injector()),
  );

  injector.registerLazySingleton<ChannelVideosUseCase>(
    () => ChannelVideosUseCase(injector()),
  );

  injector.registerLazySingleton<DeleteSubscriptionUseCase>(
    () => DeleteSubscriptionUseCase(injector()),
  );

  injector.registerLazySingleton<ChannelPlayListItemsUseCase>(
    () => ChannelPlayListItemsUseCase(injector()),
  );

  injector.registerLazySingleton<ChannelPlayListUseCase>(
    () => ChannelPlayListUseCase(injector()),
  );

  injector.registerLazySingleton<SubscribeToChannelUseCase>(
    () => SubscribeToChannelUseCase(injector()),
  );

  injector.registerLazySingleton<RelatedVideosToThisVideoUseCase>(
    () => RelatedVideosToThisVideoUseCase(injector()),
  );

  injector.registerLazySingleton<SearchForThisSentenceUseCase>(
    () => SearchForThisSentenceUseCase(injector()),
  );
  injector.registerLazySingleton<SuggestionSearchTextsUseCase>(
    () => SuggestionSearchTextsUseCase(injector()),
  );

  injector.registerLazySingleton<RateVideoUseCase>(
    () => RateVideoUseCase(injector()),
  );

  injector.registerLazySingleton<AllShortVideosUseCase>(
    () => AllShortVideosUseCase(injector()),
  );

  injector.registerLazySingleton<AllVideosUseCase>(
    () => AllVideosUseCase(injector()),
  );

  // comment use cases
  injector.registerLazySingleton<GetFirstCommentUseCase>(
    () => GetFirstCommentUseCase(injector()),
  );

  injector.registerLazySingleton<GetAllRepliesUseCase>(
    () => GetAllRepliesUseCase(injector()),
  );

  injector.registerLazySingleton<GetAllCommentsUseCase>(
    () => GetAllCommentsUseCase(injector()),
  );
  injector.registerLazySingleton<GetVideoRatingUseCase>(
    () => GetVideoRatingUseCase(injector()),
  );
  injector.registerLazySingleton<GetVideosOfThoseChannelsUseCase>(
    () => GetVideosOfThoseChannelsUseCase(injector()),
  );

  // clear use cases

  injector.registerLazySingleton<CleaChannelPlaylistsUseCase>(
    () => CleaChannelPlaylistsUseCase(injector()),
  );

  injector.registerLazySingleton<ClearVideosOfThoseChannelsUseCase>(
    () => ClearVideosOfThoseChannelsUseCase(injector()),
  );

  injector.registerLazySingleton<ClearAllPopularChannelVideosUseCase>(
    () => ClearAllPopularChannelVideosUseCase(injector()),
  );

  injector.registerLazySingleton<ClearAllPopularChannelShortVideosUseCase>(
    () => ClearAllPopularChannelShortVideosUseCase(injector()),
  );

  injector.registerLazySingleton<ClearAllChannelVideosUseCase>(
    () => ClearAllChannelVideosUseCase(injector()),
  );

  injector.registerLazySingleton<ClearAllChannelShortVideosUseCase>(
    () => ClearAllChannelShortVideosUseCase(injector()),
  );

  injector.registerLazySingleton<ClearMySubscriptionsChannelsUseCase>(
    () => ClearMySubscriptionsChannelsUseCase(injector()),
  );

  injector.registerLazySingleton<ClearAllPopularVideosUseCase>(
    () => ClearAllPopularVideosUseCase(injector()),
  );

  injector.registerLazySingleton<ClearAllVideosUseCase>(
    () => ClearAllVideosUseCase(injector()),
  );

  injector.registerLazySingleton<ClearAllShortVideosUseCase>(
    () => ClearAllShortVideosUseCase(injector()),
  );

  // *--------->
  /// ================================ Blocs ========================================>

  injector.registerFactory<ChannelVideosCubit>(
    () => ChannelVideosCubit(
        injector(),
        injector(),
        injector(),
        injector(),
        injector(),
        injector(),
        injector(),
        injector(),
        injector(),
        injector(),
        injector()),
  );
  injector.registerFactory<PlayListCubit>(
    () => PlayListCubit(injector(), injector()),
  );
  injector.registerFactory<SearchCubit>(
    () => SearchCubit(injector(), injector(), injector()),
  );

  injector.registerFactory<ChannelDetailsCubit>(
    () => ChannelDetailsCubit(
        injector(), injector(), injector(), injector(), injector()),
  );
  injector.registerFactory<SingleVideoCubit>(
    () => SingleVideoCubit(
      injector(),
      injector(),
      injector(),
      injector(),
      injector(),
      injector(),
    ),
  );
  injector.registerFactory<VideosDetailsCubit>(
    () => VideosDetailsCubit(injector(), injector(), injector(), injector()),
  );
  injector.registerFactory<PopularVideosCubit>(
    () => PopularVideosCubit(injector(), injector()),
  );

  // *
}

Dio createAndSetupDio() {
  Dio dio = Dio();

  dio
    ..options.connectTimeout = 200 * 1000
    ..options.receiveTimeout = 200 * 1000;

  dio.interceptors.add(LogInterceptor(
    responseBody: true,
    error: true,
    requestHeader: false,
    responseHeader: false,
    request: true,
    requestBody: true,
  ));

  return dio;
}
