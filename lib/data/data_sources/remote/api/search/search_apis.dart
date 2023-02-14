import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:youtube/core/utility/constants.dart';
import 'package:youtube/core/utility/private_key.dart';
import 'package:youtube/data/models/videos_details/suggestion_videos_details/suggestion_videos_details.dart';
import 'package:youtube/data/models/videos_details/videos_details.dart';
part 'search_apis.g.dart';

@RestApi(baseUrl: youtubeBaseUrl)
abstract class SearchAPIs {
  factory SearchAPIs(Dio dio, {String baseUrl}) = _SearchAPIs;

  @GET("search?part=snippet")
  Future<VideosDetails> searchForThisSentence({
    @Query("key") final String apiKey = apiKey,
    @Query("q") required String sentence,
  });

  @GET("search?part=snippet&maxResults=100&type=video")
  Future<SuggestionVideosDetails> getRelatedVideosToThisVideo({
    @Query("key") final String apiKey = apiKey,
    @Query("relatedToVideoId") required String relatedToVideoId,
  });
}
