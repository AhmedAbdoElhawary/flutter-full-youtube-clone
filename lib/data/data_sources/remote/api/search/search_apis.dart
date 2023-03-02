import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:youtube/core/utility/constants.dart';
import 'package:youtube/core/utility/private_key.dart';
import 'package:youtube/data/models/searched_video_details/searched_video_details.dart';
part 'search_apis.g.dart';

@RestApi(baseUrl: youtubeBaseUrl)
abstract class SearchAPIs {
  factory SearchAPIs(Dio dio, {String baseUrl}) = _SearchAPIs;

  @GET("search?part=snippet&type=video&videoDuration=medium&videoDuration=long")
  Future<SearchedVideosDetails> getIdsForThisSentence({
    @Query("key") final String apiKey = apiKey,
    @Query("q") required String sentence,
  });

  @GET("search?part=snippet&maxResults=2&type=video")
  Future<SearchedVideosDetails> getRelatedVideosIdsToThisVideo({
    @Query("key") final String apiKey = apiKey,
    @Query("relatedToVideoId") required String relatedToVideoId,
  });
}
