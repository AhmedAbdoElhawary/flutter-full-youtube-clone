import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:youtube/core/utility/constants.dart';
import 'package:youtube/core/utility/private_key.dart';
import 'package:youtube/data/models/videos_details/videos_details.dart';
part 'single_video_apis.g.dart';

@RestApi(baseUrl: youtubeBaseUrl)
abstract class SingleVideosAPIs {
  factory SingleVideosAPIs(Dio dio, {String baseUrl}) = _SingleVideosAPIs;

  @GET("videos?part=contentDetails,statistics,snippet")
  Future<VideosDetails> getVideoDetails({
    @Query("key") final String apiKey = apiKey,
    @Query("id") required String videoId,
  });

  /// [rating]	string
  /// Specifies the rating to record.
  ///
  /// Acceptable values are:
  /// dislike – Records that the authenticated user disliked the video.
  /// like – Records that the authenticated user liked the video.
  /// none – Removes any rating that the authenticated user had previously set for the video.

  @POST('videos/rate')
  Future<void> rateVideo({
    @Query('id')required String videoId,
    @Query('rating')required String rating,
    @Query('access_token')required String accessToken,
  });
}
