import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:youtube/core/utility/constants.dart';
import 'package:youtube/core/utility/private_key.dart';
import 'package:youtube/data/models/searched_video_details/searched_video_details.dart';
part 'channel_videos_apis.g.dart';

@RestApi(baseUrl: youtubeBaseUrl)
abstract class ChannelVideosAPIs {
  factory ChannelVideosAPIs(Dio dio, {String baseUrl}) = _ChannelVideosAPIs;
  @GET("search?part=snippet&type=video&maxResults=2")
  Future<SearchedVideosDetails> getAllChannelVideosIds({
    @Query("key") final String apiKey = apiKey,
    @Query("channelId") required String channelId,
    @Query("order") String orderVideos = "date",
  });

  @GET("search?part=snippet&type=video&maxResults=2&videoDuration=short")
  Future<SearchedVideosDetails> getAllChannelShortVideosIds({
    @Query("key") final String apiKey = apiKey,
    @Query("channelId") required String channelId,
    @Query("order") String orderVideos = "date",
  });
}
