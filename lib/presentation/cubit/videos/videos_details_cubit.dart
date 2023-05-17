import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:youtube/core/helpers/handling_errors/api_result.dart';
import 'package:youtube/core/helpers/handling_errors/network_exception_model.dart';

import 'package:youtube/data/models/videos_details/videos_details.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:youtube/domain/use_cases/search_details/related_videos_to_this_video_use_case.dart';
import 'package:youtube/domain/use_cases/videos_details/all_short_videos_use_case.dart';
import 'package:youtube/domain/use_cases/videos_details/all_videos_use_case.dart';
import 'package:youtube/domain/use_cases/videos_details/clear/clear_all_short_videos_use_case.dart';
import 'package:youtube/domain/use_cases/videos_details/clear/clear_all_videos_use_case.dart';
part 'videos_details_state.dart';
part 'videos_details_cubit.freezed.dart';

class VideosDetailsCubit extends Cubit<VideosDetailsState> {
  final AllVideosUseCase _allVideosUseCase;
  final AllShortVideosUseCase _allShortVideosUseCase;
  final ClearAllVideosUseCase _clearAllVideosUseCase;
  final ClearAllShortVideosUseCase _clearAllShortVideosUseCase;
  final RelatedVideosToThisVideoUseCase _relatedVideosToThisVideoUseCase;

  VideosDetailsCubit(
      this._relatedVideosToThisVideoUseCase,
      this._allVideosUseCase,
      this._allShortVideosUseCase,
      this._clearAllShortVideosUseCase,
      this._clearAllVideosUseCase)
      : super(const VideosDetailsState.initial());

  static VideosDetailsCubit get(BuildContext context) =>
      BlocProvider.of(context);

  Future<void> getAllVideos() async {
    emit(const VideosDetailsState.videoLoading());

    ApiResult<VideosDetails> result =
        await _allVideosUseCase.call(params: null);

    result.when(
        success: (allVideos) =>
            emit(VideosDetailsState.allVideosLoaded(allVideos)),
        failure: (exception) => emit(VideosDetailsState.videoError(exception)));
  }

  Future<void> getAllShortVideos() async {
    emit(const VideosDetailsState.videoLoading());

    ApiResult<VideosDetails> result =
        await _allShortVideosUseCase.call(params: null);

    result.when(
        success: (allShortVideos) =>
            emit(VideosDetailsState.allShortVideosLoaded(allShortVideos)),
        failure: (exception) => emit(VideosDetailsState.videoError(exception)));
  }

  Future<void> relatedVideosToThisVideo(String relatedToVideoId) async {
    emit(const VideosDetailsState.videoLoading());

    ApiResult<VideosDetails> result =
        await _relatedVideosToThisVideoUseCase.call(
            params: RelatedVideosToThisVideoUseCasePara(
                relatedToVideoId: relatedToVideoId));

    result.when(
        success: (videoDetails) =>
            emit(VideosDetailsState.relatedVideosLoaded(videoDetails)),
        failure: (exception) =>
            emit(VideosDetailsState.videoError(exception)));
  }

  Future<void> clearAllVideos() async {
    _clearAllVideosUseCase.call(params: null);
  }

  Future<void> clearAllShortVideos() async {
    _clearAllShortVideosUseCase.call(params: null);
  }
}
