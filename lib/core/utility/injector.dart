import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:youtube/data/data_sources/remote/api/channel/channel_apis.dart';
import 'package:youtube/data/data_sources/remote/api/videos/videos_apis.dart';
import 'package:youtube/data/repositories_impl/channel_details_repo_impl.dart';
import 'package:youtube/data/repositories_impl/videos_details_repo_impl.dart';
import 'package:youtube/domain/repositories/channel_details_repository.dart';
import 'package:youtube/domain/repositories/videos_details_repository.dart';
import 'package:youtube/domain/use_cases/channel_details/channel_sub_details_use_case.dart';
import 'package:youtube/domain/use_cases/videos_details/get_video_details_usecase.dart';
import 'package:youtube/domain/use_cases/videos_details/most_popular_videos_use_case.dart';
import 'package:youtube/presentation/cubit/videos_details/videos_details_cubit.dart';

final injector = GetIt.I;

Future<void> initializeDependencies() async {
  /// =============================== Data source =========================================>

  injector
      .registerLazySingleton<VideosAPIs>(() => VideosAPIs(createAndSetupDio()));

  injector.registerLazySingleton<ChannelAPIs>(
      () => ChannelAPIs(createAndSetupDio()));

  /// =============================== Repository =========================================>

  // videos details Repository

  injector.registerLazySingleton<VideoDetailsRepository>(
    () => VideoDetailsRepoImpl(injector()),
  );
  injector.registerLazySingleton<ChannelDetailsRepository>(
    () => ChannelDetailsRepoImpl(injector()),
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

  // *
  /// ================================ Blocs ========================================>

  // auth cubit
  injector.registerFactory<VideosDetailsCubit>(
    () => VideosDetailsCubit(injector(), injector(), injector()),
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
