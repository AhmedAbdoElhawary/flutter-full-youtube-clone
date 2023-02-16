import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:youtube/core/functions/api_result.dart';

import 'package:youtube/data/models/videos_details/videos_details.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:youtube/domain/use_cases/videos_details/all_short_videos_use_case.dart';
import 'package:youtube/domain/use_cases/videos_details/all_videos_use_case.dart';
part 'videos_details_state.dart';
part 'videos_details_cubit.freezed.dart';

class VideosDetailsCubit extends Cubit<VideosDetailsState> {
  final AllVideosUseCase _allVideosUseCase;
  final AllShortVideosUseCase _allShortVideosUseCase;

  VideosDetailsCubit(this._allVideosUseCase, this._allShortVideosUseCase)
      : super(const VideosDetailsState.initial());

  static VideosDetailsCubit get(BuildContext context) =>
      BlocProvider.of(context);

  Future<void> getAllVideos() async {
    emit(const VideosDetailsState.loading());

    ApiResult<VideosDetails> result =
        await _allVideosUseCase.call(params: null);

    result.when(
        success: (allVideos) =>
            emit(VideosDetailsState.allVideosLoaded(allVideos)),
        failure: (exception) => emit(VideosDetailsState.error(exception)));
  }

  Future<void> getAllShortVideos() async {
    emit(const VideosDetailsState.loading());

    ApiResult<VideosDetails> result =
        await _allShortVideosUseCase.call(params: null);

    result.when(
        success: (allShortVideos) =>
            emit(VideosDetailsState.allShortVideosLoaded(allShortVideos)),
        failure: (exception) => emit(VideosDetailsState.error(exception)));
  }
}
