import 'package:youtube/core/functions/api_result.dart';
import 'package:youtube/data/models/comment_details/comment_details.dart';
import 'package:youtube/data/models/reply_details/reply_details.dart';
import 'package:youtube/data/models/videos_details/videos_details.dart';

abstract class SingleVideoDetailsRepository {
  Future<ApiResult<VideosDetails>> getVideoDetails({required String videoId});
  Future<ApiResult<CommentDetails>> getAllComments({required String videoId});
  Future<ApiResult<CommentDetails>> getFirstComment({required String videoId});
  Future<ApiResult<ReplyDetails>> getRepliesForThisComment(
      {required String commentId});
}
