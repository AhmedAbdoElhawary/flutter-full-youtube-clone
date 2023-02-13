import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:youtube/core/utility/constants.dart';
import 'package:youtube/core/utility/private_key.dart';
import 'package:youtube/data/models/video_details/video_details.dart';
part 'videos_apis.g.dart';

@RestApi(baseUrl: youtubeBaseUrl)
abstract class VideosAPIs {
  factory VideosAPIs(Dio dio, {String baseUrl}) = _VideosAPIs;

  @GET(
      "videos?part=contentDetails,statistics,snippet&chart=mostPopular&maxResults=50&regionCode=EG")
  Future<VideosDetails> getMostPopularVideos({
    @Query("key") final String apiKey = apiKey,
  });
}
