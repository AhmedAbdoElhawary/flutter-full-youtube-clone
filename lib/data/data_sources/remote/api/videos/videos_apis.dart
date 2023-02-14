import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:youtube/core/utility/constants.dart';
import 'package:youtube/core/utility/private_key.dart';
import 'package:youtube/data/models/videos_details/videos_details.dart';
part 'videos_apis.g.dart';

@RestApi(baseUrl: youtubeBaseUrl)
abstract class VideosAPIs {
  factory VideosAPIs(Dio dio, {String baseUrl}) = _VideosAPIs;

  @GET(
      "search?part=snippet&location=30.044420,31.235712&locationRadius=1000km&type=video&maxResults=50")
  Stream<VideosDetails> getAllVideos({
    @Query("key") final String apiKey = apiKey,
  });

  @GET(
      "videos?part=contentDetails,statistics,snippet&chart=mostPopular&maxResults=50&regionCode=EG")
  Stream<VideosDetails> getMostPopularVideos({
    @Query("key") final String apiKey = apiKey,
  });
}
