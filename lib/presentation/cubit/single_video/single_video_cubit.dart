import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:youtube/core/functions/handling_errors/api_result.dart';
import 'package:youtube/core/functions/handling_errors/network_exception_model.dart';

import 'package:youtube/data/models/comment_details/comment_details.dart';
import 'package:youtube/data/models/rating_details/rating_details.dart';
import 'package:youtube/data/models/reply_details/reply_details.dart';
import 'package:youtube/data/models/videos_details/videos_details.dart';
import 'package:youtube/domain/entities/parameters/video_details_use_case_parameter.dart';
import 'package:youtube/domain/use_cases/single_video/comment/get_all_comments_use_case.dart';
import 'package:youtube/domain/use_cases/single_video/comment/get_all_replies_use_case.dart';
import 'package:youtube/domain/use_cases/single_video/comment/get_first_comment_use_case.dart';
import 'package:youtube/domain/use_cases/single_video/get_video_details_use_case.dart';
import 'package:youtube/domain/use_cases/single_video/get_video_rating_use_case.dart';
import 'package:youtube/domain/use_cases/single_video/rate_video_use_case.dart';

part 'single_video_state.dart';
part 'single_video_cubit.freezed.dart';

class SingleVideoCubit extends Cubit<SingleVideoState> {
  final VideoDetailsUseCase _videoDetailsUseCase;
  final GetFirstCommentUseCase _firstCommentUseCase;
  final GetAllCommentsUseCase _allCommentsUseCase;
  final GetAllRepliesUseCase _allRepliesUseCase;
  final GetVideoRatingUseCase _getVideoRatingUseCase;
  final RateVideoUseCase _rateVideoUseCase;
  SingleVideoCubit(
    this._videoDetailsUseCase,
    this._allRepliesUseCase,
    this._allCommentsUseCase,
    this._firstCommentUseCase,
    this._getVideoRatingUseCase,
    this._rateVideoUseCase,
  ) : super(const SingleVideoState.initial());

  static SingleVideoCubit get(BuildContext context) =>
      BlocProvider.of<SingleVideoCubit>(context);

  Future<void> getVideoDetails({required String videoId}) async {
    emit(const SingleVideoState.videoInfoLoading());

    ApiResult<VideosDetails> result = await _videoDetailsUseCase.call(
        params: VideoDetailsUseCaseParameters(videoId: videoId));

    result.when(
        success: (videoDetails) =>
            emit(SingleVideoState.videoDetailsLoaded(videoDetails)),
        failure: (exception) => emit(SingleVideoState.videoInfoError(exception)));
  }

  Future<void> getVideoRating({required String videoId}) async {
    emit(const SingleVideoState.videoInfoLoading());

    ApiResult<RatingDetails> result = await _getVideoRatingUseCase.call(
        params: GetVideoRatingUseCaseParameter(videoId: videoId));

    result.when(
        success: (ratingDetails) =>
            emit(SingleVideoState.getVideoRatingLoaded(ratingDetails)),
        failure: (exception) => emit(SingleVideoState.videoInfoError(exception)));
  }

  Future<void> rateThisVideo(
      {required String videoId, required String rating}) async {
    emit(const SingleVideoState.videoInfoLoading());

    ApiResult<void> result = await _rateVideoUseCase.call(
        params: RateVideoUseCaseParameter(videoId: videoId, rating: rating));

    result.when(
        success: (_) => emit(const SingleVideoState.ratingVideoLoaded()),
        failure: (exception) => emit(SingleVideoState.videoInfoError(exception)));
  }

  Future<void> getFirstComment(String videoId) async {
    emit(const SingleVideoState.videoInfoLoading());

    ApiResult<CommentDetails> result = await _firstCommentUseCase.call(
        params: VideoDetailsUseCaseParameters(videoId: videoId));

    result.when(
        success: (commentDetails) =>
            emit(SingleVideoState.firstCommentLoaded(commentDetails)),
        failure: (exception) => emit(SingleVideoState.videoInfoError(exception)));
  }

  Future<void> getAllComments(String videoId) async {
    emit(const SingleVideoState.videoInfoLoading());

    ApiResult<CommentDetails> result = await _allCommentsUseCase.call(
        params: VideoDetailsUseCaseParameters(videoId: videoId));

    result.when(
        success: (commentDetails) =>
            emit(SingleVideoState.allCommentLoaded(commentDetails)),
        failure: (exception) => emit(SingleVideoState.videoInfoError(exception)));
  }

  Future<void> getAllReplies(String commentId) async {
    emit(const SingleVideoState.videoInfoLoading());

    ApiResult<ReplyDetails> result = await _allRepliesUseCase.call(
        params: GetAllRepliesUseCaseParameters(commentId: commentId));

    result.when(
        success: (commentDetails) =>
            emit(SingleVideoState.allRepliesLoaded(commentDetails)),
        failure: (exception) => emit(SingleVideoState.videoInfoError(exception)));
  }
}
