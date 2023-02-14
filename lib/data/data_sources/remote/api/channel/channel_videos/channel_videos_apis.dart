import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:youtube/core/utility/constants.dart';
import 'package:youtube/core/utility/private_key.dart';
import 'package:youtube/data/models/channel_details/channel_videos_ids/channel_videos_ids.dart';
import 'package:youtube/data/models/videos_details/videos_details.dart';
part 'channel_videos_apis.g.dart';

@RestApi(baseUrl: youtubeBaseUrl)
abstract class ChannelVideosAPIs {
  factory ChannelVideosAPIs(Dio dio, {String baseUrl}) = _ChannelVideosAPIs;

  @GET("search?&order=date&type=video&part=id&maxResults=50")
  Stream<ChannelVideosIds> getChannelVideosIds({
    @Query("key") final String apiKey = apiKey,
    @Query("channelId") required String channelId,
  });

  @GET("videos?part=snippet%2CcontentDetails%2Cstatistics&maxResults=50")
  Stream<VideosDetails> getChannelVideos({
    @Query("key") final String apiKey = apiKey,
    @Query("id") required String videosIds,
    @Query("order") String orderVideos ="date",
  });

  @GET("search?type=video&videoDuration=short&part=snippet&maxResults=50")
  Stream<VideosDetails> getChannelShortVideos({
    @Query("key") final String apiKey = apiKey,
    @Query("id") required String videosIds,
    @Query("order") String orderVideos ="date",
  });
}
