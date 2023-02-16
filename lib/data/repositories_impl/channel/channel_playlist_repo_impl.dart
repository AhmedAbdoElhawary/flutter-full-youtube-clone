import 'package:youtube/core/functions/api_result.dart';

import 'package:youtube/data/data_sources/remote/api/channel/channel_playlist/channel_playlist_apis.dart';
import 'package:youtube/data/models/channel_details/playlists/playlist_videos.dart';
import 'package:youtube/data/models/channel_details/playlists/playlists.dart';
import 'package:youtube/domain/repositories/channel/channel_playlist_repository.dart';

class ChannelPlayListDetailsRepoImpl
    implements ChannelPlayListDetailsRepository {
  final ChannelPlayListAPIs _channelPlayListAPIs;

  ChannelPlayListDetailsRepoImpl(this._channelPlayListAPIs);

  @override
  Future<ApiResult<PlayListVideos>> getChannelPlayListItem(
      {required String playlistId}) async {
    try {
      PlayListVideos channelPlayListItem = await _channelPlayListAPIs
          .getChannelPlayListItem(playlistId: playlistId);

      return ApiResult.success(channelPlayListItem);
    } catch (e) {
      return ApiResult.failure(e.toString());
    }
  }

  @override
  Future<ApiResult<PlayLists>> getChannelPlayLists(
      {required String channelId}) async {
    try {
      PlayLists playLists =
          await _channelPlayListAPIs.getChannelPlayLists(channelId: channelId);

      return ApiResult.success(playLists);
    } catch (e) {
      return ApiResult.failure(e.toString());
    }
  }
}
