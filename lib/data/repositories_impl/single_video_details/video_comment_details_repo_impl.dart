import 'package:youtube/core/functions/api_result.dart';
import 'package:youtube/core/functions/network_exceptions.dart';
import 'package:youtube/data/data_sources/remote/api/single_video/commet/comment_apis.dart';
import 'package:youtube/data/models/comment_details/comment_details.dart';
import 'package:youtube/data/models/reply_details/reply_details.dart';
import 'package:youtube/domain/repositories/video_comment_details/video_comment_details_repositroy.dart';

class SingleVideosDetailsRepoImpl implements VideoCommentDetailsRepository {
  final CommentAPIs _commentAPIs;

  SingleVideosDetailsRepoImpl(this._commentAPIs);

  @override
  Future<ApiResult<CommentDetails>> getAllComments(
      {required String videoId}) async {
    try {
      CommentDetails commentDetails =
          await _commentAPIs.getAllComments(videoId: videoId);
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
          await _commentAPIs.getFirstComment(videoId: videoId);
      return ApiResult.success(firstComment);
    } catch (e) {
      return ApiResult.failure(NetworkExceptions.getDioException(e));
    }
  }

  @override
  Future<ApiResult<ReplyDetails>> getRepliesForThisComment(
      {required String commentId}) async {
    try {
      ReplyDetails replies =
          await _commentAPIs.getRepliesForThisComment(commentId: commentId);
      return ApiResult.success(replies);
    } catch (e) {
      return ApiResult.failure(NetworkExceptions.getDioException(e));
    }
  }
}
