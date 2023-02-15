import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:youtube/core/utility/constants.dart';
import 'package:youtube/core/utility/private_key.dart';
import 'package:youtube/data/models/common/videos_ids/videos_ids.dart';
part 'channel_videos_apis.g.dart';

@RestApi(baseUrl: youtubeBaseUrl)
abstract class ChannelVideosAPIs {
  factory ChannelVideosAPIs(Dio dio, {String baseUrl}) = _ChannelVideosAPIs;
  @GET("search?type=video&part=id&maxResults=50")
  Future<VideosIdsDetails> getAllChannelVideosIds({
    @Query("key") final String apiKey = apiKey,
    @Query("channelId") required String channelId,
    @Query("order") String orderVideos = "date",
  });

  @GET("search?type=video&part=id&maxResults=50&videoDuration=short")
  Future<VideosIdsDetails> getAllChannelShortVideosIds({
    @Query("key") final String apiKey = apiKey,
    @Query("channelId") required String channelId,
    @Query("order") String orderVideos = "date",
  });
}
