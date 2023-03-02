import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:youtube/core/utility/constants.dart';
import 'package:youtube/core/utility/private_key.dart';
import 'package:youtube/data/models/comment_details/comment_body/comment_body.dart';
import 'package:youtube/data/models/comment_details/comment_details.dart';
import 'package:youtube/data/models/reply_details/reply_details.dart';
part 'comment_apis.g.dart';

@RestApi(baseUrl: youtubeBaseUrl)
abstract class CommentAPIs {
  factory CommentAPIs(Dio dio) = _CommentAPIs;

  @GET("commentThreads?part=snippet&maxResults=2")
  Future<CommentDetails> getAllComments({
    @Query("key") final String apiKey = apiKey,
    @Query("videoId") required String videoId,
  });

  @GET("commentThreads?part=snippet&maxResults=1")
  Future<CommentDetails> getFirstComment({
    @Query("key") final String apiKey = apiKey,
    @Query("videoId") required String videoId,
  });

  @GET("commentThreads?part=replies&maxResults=2")
  Future<ReplyDetails> getRepliesForThisComment({
    @Query("key") final String apiKey = apiKey,
    @Query("id") required String commentId,
  });

  /// [insertComment] for reply and comment: just set parentId if you want a reply
  @POST("comments?part=snippet")
  Future<dynamic> insertComment(
      {@Query("access_token") required String accessToken,
      @Query("key") final String apiKey = apiKey,
      @Body() required CommentBody commentBody});
}
