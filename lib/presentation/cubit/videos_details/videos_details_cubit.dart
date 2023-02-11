import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:youtube/core/functions/api_result.dart';
import 'package:youtube/core/functions/network_exceptions.dart';
import 'package:youtube/data/models/video_details/video_details.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:youtube/domain/use_cases/videos_details/get_video_details_usecase.dart';
import 'package:youtube/domain/use_cases/videos_details/most_popular_videos_use_case.dart';
part 'videos_details_state.dart';
part 'videos_details_cubit.freezed.dart';

class VideosDetailsCubit extends Cubit<VideosDetailsState> {
  VideosDetailsCubit(this._videoDetailsUseCase, this._mostPopularVideosUseCase)
      : super(const VideosDetailsState.initial());
  final MostPopularVideosUseCase _mostPopularVideosUseCase;
  final VideoDetailsUseCase _videoDetailsUseCase;
  static VideosDetailsCubit get(BuildContext context) =>
      BlocProvider.of(context);

  Future<void> getMostPopularVideos() async {
    emit(const VideosDetailsState.loading());

    ApiResult<VideoDetails> result =
        await _mostPopularVideosUseCase.call(params: null);

    result.when(
        success: (mostPopularVideos) =>
            emit(VideosDetailsState.mostPopularVideosLoaded(mostPopularVideos)),
        failure: (exception) => emit(VideosDetailsState.error(exception)));
  }

  Future<void> getVideosDetails(String videoId) async {
    emit(const VideosDetailsState.loading());

    ApiResult<VideoDetails> result = await _videoDetailsUseCase.call(
        params: VideoDetailsUseCaseParameters(videoId: videoId));

    result.when(
        success: (mostPopularVideos) =>
            emit(VideosDetailsState.videoDetailsLoaded(mostPopularVideos)),
        failure: (exception) => emit(VideosDetailsState.error(exception)));
  }
}
