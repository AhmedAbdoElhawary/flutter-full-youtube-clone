import 'package:youtube/core/functions/api_result.dart';
import 'package:youtube/core/functions/network_exceptions.dart';
import 'package:youtube/data/data_sources/local/channnel/interfaces/cache_channel_playlist_apis.dart';

import 'package:youtube/data/data_sources/remote/api/channel/channel_playlist/channel_playlist_apis.dart';
import 'package:youtube/data/models/channel_details/playlists/playlist_videos.dart';
import 'package:youtube/data/models/channel_details/playlists/playlists.dart';
import 'package:youtube/domain/repositories/channel/channel_playlist_repository.dart';

class ChannelPlayListDetailsRepoImpl
    implements ChannelPlayListDetailsRepository {
  final ChannelPlayListAPIs _channelPlayListAPIs;
  final CacheChannelPlaylistAPIs _cacheChannelPlaylistAPIs;
  ChannelPlayListDetailsRepoImpl(
      this._channelPlayListAPIs, this._cacheChannelPlaylistAPIs);

  @override
  void clearChannelPlayLists({required String channelId}) {
    _cacheChannelPlaylistAPIs.clearChannelPlayLists(channelId: channelId);
  }

  @override
  Future<ApiResult<PlayLists>> getChannelPlayLists(
      {required String channelId}) async {
    try {
      /// get from caching if it exist.
      PlayLists? cachedVideos =
          _cacheChannelPlaylistAPIs.getChannelPlayLists(channelId: channelId);
      if (cachedVideos != null) return ApiResult.success(cachedVideos);

      PlayLists playLists =
          await _channelPlayListAPIs.getChannelPlayLists(channelId: channelId);

      /// caching videos
      _cacheChannelPlaylistAPIs.saveChannelPlayLists(
          channelId: channelId, playLists: playLists);

      return ApiResult.success(playLists);
    } catch (e) {
      return ApiResult.failure(NetworkExceptions.getDioException(e));
    }
  }

  @override
  Future<ApiResult<PlayListVideos>> getChannelPlayListItem(
      {required String playlistId}) async {
    try {
      PlayListVideos channelPlayListItem = await _channelPlayListAPIs
          .getChannelPlayListItem(playlistId: playlistId);

      return ApiResult.success(channelPlayListItem);
    } catch (e) {
      return ApiResult.failure(NetworkExceptions.getDioException(e));
    }
  }
}
