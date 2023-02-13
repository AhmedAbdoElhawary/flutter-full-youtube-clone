import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:youtube/data/data_sources/remote/api/channel/channel_apis.dart';
import 'package:youtube/data/data_sources/remote/api/search/search_apis.dart';
import 'package:youtube/data/data_sources/remote/api/single_video/single_video_apis.dart';
import 'package:youtube/data/data_sources/remote/api/videos/videos_apis.dart';
import 'package:youtube/data/repositories_impl/channel_details_repo_impl.dart';
import 'package:youtube/data/repositories_impl/single_video_details_repo_impl.dart';
import 'package:youtube/data/repositories_impl/videos_details_repo_impl.dart';
import 'package:youtube/domain/repositories/channel_details_repository.dart';
import 'package:youtube/domain/repositories/single_video_details_repository.dart';
import 'package:youtube/domain/repositories/videos_details_repository.dart';
import 'package:youtube/domain/use_cases/channel_details/channel_sub_details_use_case.dart';
import 'package:youtube/domain/use_cases/single_video/get_all_comments_use_case.dart';
import 'package:youtube/domain/use_cases/single_video/get_all_replies_use_case.dart';
import 'package:youtube/domain/use_cases/single_video/get_first_comment_use_case.dart';
import 'package:youtube/domain/use_cases/single_video/get_video_details_use_case.dart';
import 'package:youtube/domain/use_cases/videos_details/most_popular_videos_use_case.dart';
import 'package:youtube/presentation/cubit/channel_details/channel_details_cubit.dart';
import 'package:youtube/presentation/cubit/single_video_details/single_video_cubit.dart';
import 'package:youtube/presentation/cubit/videos_details/videos_details_cubit.dart';

final injector = GetIt.I;

Future<void> initializeDependencies() async {
  /// =============================== Data source =========================================>

  injector
      .registerLazySingleton<VideosAPIs>(() => VideosAPIs(createAndSetupDio()));

  injector.registerLazySingleton<ChannelAPIs>(
      () => ChannelAPIs(createAndSetupDio()));

  injector.registerLazySingleton<SingleVideosAPIs>(
      () => SingleVideosAPIs(createAndSetupDio()));

  injector
      .registerLazySingleton<SearchAPIs>(() => SearchAPIs(createAndSetupDio()));

  /// =============================== Repository =========================================>

  // videos details Repository

  injector.registerLazySingleton<VideosDetailsRepository>(
    () => VideosDetailsRepoImpl(injector(), injector()),
  );
  injector.registerLazySingleton<ChannelDetailsRepository>(
    () => ChannelDetailsRepoImpl(injector()),
  );
  injector.registerLazySingleton<SingleVideoDetailsRepository>(
    () => SingleVideosDetailsRepoImpl(injector(), injector()),
  );

  // *
  /// ================================ Blocs ========================================>

  injector.registerLazySingleton<VideoDetailsUseCase>(
    () => VideoDetailsUseCase(injector()),
  );

  injector.registerLazySingleton<MostPopularVideosUseCase>(
    () => MostPopularVideosUseCase(injector()),
  );

  injector.registerLazySingleton<ChannelSubDetailsUseCase>(
    () => ChannelSubDetailsUseCase(injector()),
  );
  injector.registerLazySingleton<GetFirstCommentUseCase>(
    () => GetFirstCommentUseCase(injector()),
  );

  injector.registerLazySingleton<GetAllRepliesUseCase>(
    () => GetAllRepliesUseCase(injector()),
  );

  injector.registerLazySingleton<GetAllCommentsUseCase>(
    () => GetAllCommentsUseCase(injector()),
  );

  // *
  /// ================================ Blocs ========================================>

  injector.registerFactory<ChannelDetailsCubit>(
    () => ChannelDetailsCubit(injector()),
  );
  injector.registerFactory<SingleVideoCubit>(
    () => SingleVideoCubit(injector(), injector(), injector(), injector()),
  );
  injector.registerFactory<VideosDetailsCubit>(
    () => VideosDetailsCubit(injector()),
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
