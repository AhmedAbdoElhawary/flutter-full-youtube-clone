import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:youtube/core/utility/constants.dart';
import 'package:youtube/core/utility/private_key.dart';
import 'package:youtube/data/models/searched_video_details/searched_video_details.dart';
import 'package:youtube/data/models/videos_details/videos_details.dart';
part 'videos_apis.g.dart';

@RestApi(baseUrl: youtubeBaseUrl)
abstract class VideosAPIs {
  factory VideosAPIs(Dio dio, {String baseUrl}) = _VideosAPIs;

  @GET(
      "search?part=snippet&maxResults=2&regionCode=EG&videoDuration=medium&videoDuration=long&type=video")
  Future<SearchedVideosDetails> getAllVideosIds({
    @Query("key") final String apiKey = apiKey,
  });

  @GET(
      "search?part=snippet&maxResults=2&regionCode=EG&videoDuration=1&type=video")
  Future<SearchedVideosDetails> getAllShortVideosIds({
    @Query("key") final String apiKey = apiKey,
  });

  /// [videosIds] add ids like this: id1,id2,id3,id4
  @GET(
      "videos?part=contentDetails,statistics,snippet&maxResults=2&regionCode=EG")
  Future<VideosDetails> getVideosOfThoseIds({
    @Query("key") final String apiKey = apiKey,
    @Query("id") required String videosIds,
  });

  @GET(
      "videos?part=contentDetails,statistics,snippet&chart=mostPopular&maxResults=2&regionCode=EG")
  Future<VideosDetails> getMostPopularVideos({
    @Query("key") final String apiKey = apiKey,
    @Query("videoCategoryId") required String videoCategoryId,
  });
}
