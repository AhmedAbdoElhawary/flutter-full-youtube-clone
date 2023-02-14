import 'package:youtube/core/functions/api_result.dart';
import 'package:youtube/core/functions/network_exceptions.dart';
import 'package:youtube/data/data_sources/remote/api/single_video/single_video_apis.dart';
import 'package:youtube/data/models/comment_details/comment_details.dart';
import 'package:youtube/data/models/reply_details/reply_details.dart';
import 'package:youtube/data/models/videos_details/videos_details.dart';
import 'package:youtube/domain/repositories/channel_details_repository.dart';
import 'package:youtube/domain/repositories/single_video_details_repository.dart';

class SingleVideosDetailsRepoImpl implements SingleVideoDetailsRepository {
  final SingleVideosAPIs _singleVideosAPIs;
  final ChannelDetailsRepository _channelDetailsRepository;

  SingleVideosDetailsRepoImpl(
      this._singleVideosAPIs, this._channelDetailsRepository);

  @override
  Future<ApiResult<VideosDetails>> getVideoDetails(
      {required String videoId}) async {
    try {
      VideosDetails videos =
          await _singleVideosAPIs.getVideoDetails(videoId: videoId);

      VideosDetails videosWithSubChannelDetails =
          await _channelDetailsRepository.getSubChannelsDetails(
              videosDetails: videos);

      return ApiResult.success(videosWithSubChannelDetails);
    } catch (e) {
      return ApiResult.failure(NetworkExceptions.getDioException(e));
    }
  }

  @override
  Future<ApiResult<CommentDetails>> getAllComments(
      {required String videoId}) async {
    try {
      CommentDetails commentDetails =
          await _singleVideosAPIs.getAllComments(videoId: videoId);
      return ApiResult.success(commentDetails);
    } catch (e) {
      return ApiResult.failure(NetworkExceptions.getDioException(e));
    }
  }

  @override
  Future<ApiResult<CommentDetails>> getFirstComment(
      {required String videoId}) async {
    try {
      CommentDetails firstComment =
          await _singleVideosAPIs.getFirstComment(videoId: videoId);
      return ApiResult.success(firstComment);
    } catch (e) {
      return ApiResult.failure(NetworkExceptions.getDioException(e));
    }
  }

  @override
  Future<ApiResult<ReplyDetails>> getRepliesForThisComment(
      {required String commentId}) async {
    try {
      ReplyDetails replies = await _singleVideosAPIs.getRepliesForThisComment(
          commentId: commentId);
      return ApiResult.success(replies);
    } catch (e) {
      return ApiResult.failure(NetworkExceptions.getDioException(e));
    }
  }
}
