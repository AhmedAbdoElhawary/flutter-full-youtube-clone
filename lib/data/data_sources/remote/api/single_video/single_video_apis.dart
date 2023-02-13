import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:youtube/core/utility/constants.dart';
import 'package:youtube/core/utility/private_key.dart';
import 'package:youtube/data/models/comment_details/comment_details.dart';
import 'package:youtube/data/models/reply_details/reply_details.dart';
import 'package:youtube/data/models/video_details/video_details.dart';
part 'single_video_apis.g.dart';

@RestApi(baseUrl: youtubeBaseUrl)
abstract class SingleVideosAPIs {
  factory SingleVideosAPIs(Dio dio, {String baseUrl}) = _SingleVideosAPIs;

  @GET("videos?part=contentDetails,statistics,snippet")
  Future<VideosDetails> getVideoDetails({
    @Query("key") final String apiKey = apiKey,
    @Query("id") required String videoId,
  });

  @GET("commentThreads?part=snippet&maxResults=100")
  Future<CommentDetails> getAllComments({
    @Query("key") final String apiKey = apiKey,
    @Query("videoId") required String videoId,
  });

  @GET("commentThreads?part=snippet&maxResults=1")
  Future<CommentDetails> getFirstComment({
    @Query("key") final String apiKey = apiKey,
    @Query("videoId") required String videoId,
  });

  @GET("commentThreads?part=replies&maxResults=100")
  Future<ReplyDetails> getRepliesForThisComment({
    @Query("key") final String apiKey = apiKey,
    @Query("id") required String commentId,
  });
}
