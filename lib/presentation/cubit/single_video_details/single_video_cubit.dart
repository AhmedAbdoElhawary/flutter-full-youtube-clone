import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:youtube/core/functions/api_result.dart';
import 'package:youtube/core/functions/network_exceptions.dart';
import 'package:youtube/data/models/video_details/video_details.dart';
import 'package:youtube/domain/entities/video_details_use_case_parameter.dart';
import 'package:youtube/domain/use_cases/single_video/get_first_comment_use_case.dart';
import 'package:youtube/domain/use_cases/single_video/get_video_details_use_case.dart';
import 'package:youtube/presentation/cubit/videos_details/videos_details_cubit.dart';

part 'single_video_state.dart';
part 'single_video_cubit.freezed.dart';

class SingleVideoCubit extends Cubit<SingleVideoState> {
  final VideoDetailsUseCase _videoDetailsUseCase;
  final GetFirstCommentUseCase _getFirstCommentUseCase;

  SingleVideoCubit(this._getFirstCommentUseCase, this._videoDetailsUseCase)
      : super(const SingleVideoState.initial());

  static VideosDetailsCubit get(BuildContext context) =>
      BlocProvider.of(context);

  Future<void> getVideoDetails(String videoId) async {
    emit(const SingleVideoState.loading());

    ApiResult<VideosDetails> result = await _videoDetailsUseCase.call(
        params: VideoDetailsUseCaseParameters(videoId: videoId));

    result.when(
        success: (videoDetails) => emit(SingleVideoState.videoDetailsLoaded(videoDetails)),
        failure: (exception) => emit(SingleVideoState.error(exception)));
  }
}
