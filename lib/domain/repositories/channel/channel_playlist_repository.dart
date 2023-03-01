import 'package:youtube/core/functions/api_result.dart';
import 'package:youtube/data/models/channel_details/playlists/playlist_videos.dart';
import 'package:youtube/data/models/channel_details/playlists/playlists.dart';

abstract class ChannelPlayListDetailsRepository {
  void clearChannelPlayLists({required String channelId});

  Future<ApiResult<PlayLists>> getChannelPlayLists({required String channelId});

  Future<ApiResult<PlayListVideos>> getChannelPlayListItem({
    required String playlistId,
  });
}
