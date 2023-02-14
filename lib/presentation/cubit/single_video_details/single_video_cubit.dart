import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:youtube/core/functions/api_result.dart';
import 'package:youtube/core/functions/network_exceptions.dart';
import 'package:youtube/data/models/comment_details/comment_details.dart';
import 'package:youtube/data/models/reply_details/reply_details.dart';
import 'package:youtube/data/models/videos_details/videos_details.dart';
import 'package:youtube/domain/entities/video_details_use_case_parameter.dart';
import 'package:youtube/domain/use_cases/single_video/get_all_comments_use_case.dart';
import 'package:youtube/domain/use_cases/single_video/get_all_replies_use_case.dart';
import 'package:youtube/domain/use_cases/single_video/get_first_comment_use_case.dart';
import 'package:youtube/domain/use_cases/single_video/get_video_details_use_case.dart';
import 'package:youtube/presentation/cubit/videos_details/videos_details_cubit.dart';

part 'single_video_state.dart';
part 'single_video_cubit.freezed.dart';

class SingleVideoCubit extends Cubit<SingleVideoState> {
  final VideoDetailsUseCase _videoDetailsUseCase;
  final GetFirstCommentUseCase _firstCommentUseCase;
  final GetAllCommentsUseCase _allCommentsUseCase;
  final GetAllRepliesUseCase _allRepliesUseCase;
  SingleVideoCubit(
    this._videoDetailsUseCase,
    this._allRepliesUseCase,
    this._allCommentsUseCase,
    this._firstCommentUseCase,
  ) : super(const SingleVideoState.initial());

  static VideosDetailsCubit get(BuildContext context) =>
      BlocProvider.of(context);

  Future<void> getVideoDetails(String videoId) async {
    emit(const SingleVideoState.loading());

    ApiResult<VideosDetails> result = await _videoDetailsUseCase.call(
        params: VideoDetailsUseCaseParameters(videoId: videoId));

    result.when(
        success: (videoDetails) =>
            emit(SingleVideoState.videoDetailsLoaded(videoDetails)),
        failure: (exception) => emit(SingleVideoState.error(exception)));
  }

  Future<void> getFirstComment(String videoId) async {
    emit(const SingleVideoState.loading());

    ApiResult<CommentDetails> result = await _firstCommentUseCase.call(
        params: VideoDetailsUseCaseParameters(videoId: videoId));

    result.when(
        success: (commentDetails) =>
            emit(SingleVideoState.firstCommentLoaded(commentDetails)),
        failure: (exception) => emit(SingleVideoState.error(exception)));
  }

  Future<void> getAllComments(String videoId) async {
    emit(const SingleVideoState.loading());

    ApiResult<CommentDetails> result = await _allCommentsUseCase.call(
        params: VideoDetailsUseCaseParameters(videoId: videoId));

    result.when(
        success: (commentDetails) =>
            emit(SingleVideoState.allCommentLoaded(commentDetails)),
        failure: (exception) => emit(SingleVideoState.error(exception)));
  }

  Future<void> getAllReplies(String commentId) async {
    emit(const SingleVideoState.loading());

    ApiResult<ReplyDetails> result = await _allRepliesUseCase.call(
        params: GetAllRepliesUseCaseParameters(commentId: commentId));

    result.when(
        success: (commentDetails) =>
            emit(SingleVideoState.allRepliesLoaded(commentDetails)),
        failure: (exception) => emit(SingleVideoState.error(exception)));
  }
}
