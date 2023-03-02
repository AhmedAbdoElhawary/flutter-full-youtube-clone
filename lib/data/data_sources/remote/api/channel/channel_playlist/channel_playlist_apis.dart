import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:youtube/core/utility/constants.dart';
import 'package:youtube/core/utility/private_key.dart';
import 'package:youtube/data/models/channel_details/playlists/playlist_videos.dart';
import 'package:youtube/data/models/channel_details/playlists/playlists.dart';
part 'channel_playlist_apis.g.dart';

@RestApi(baseUrl: youtubeBaseUrl)
abstract class ChannelPlayListAPIs {
  factory ChannelPlayListAPIs(Dio dio) = _ChannelPlayListAPIs;

  @GET("playlists?part=snippet%2CcontentDetails&maxResults=20")
  Future<PlayLists> getChannelPlayLists({
    @Query("key") final String apiKey = apiKey,
    @Query("channelId") required String channelId,
  });

  @GET("playlistItems?part=snippet,contentDetails&maxResults=20")
  Future<PlayListVideos> getChannelPlayListItem({
    @Query("key") final String apiKey = apiKey,
    @Query("playlistId") required String playlistId,
  });
}
