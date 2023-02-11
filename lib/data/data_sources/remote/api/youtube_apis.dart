import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:youtube/core/utility/constants.dart';
import 'package:youtube/core/utility/private_key.dart';
import 'package:youtube/data/models/video_details/video_details.dart';
part 'youtube_apis.g.dart';

@RestApi(baseUrl: youtubeBaseUrl)
abstract class YoutubeAPIs {
  factory YoutubeAPIs(Dio dio, {String baseUrl}) = _YoutubeAPIs;

  @GET("videos?part=contentDetails,statistics,snippet&chart=mostPopular&maxResults=50&regionCode=EG")
  Future<VideoDetails> getMostPopularVideos({
    @Query("key") final String apiKey = apiKey,
  });

  @GET("videos?part=contentDetails,statistics,snippet")
  Future<VideoDetails> getVideoDetails({
    @Query("key") final String apiKey = apiKey,
    @Query("id") required String videoId,
  });
}
