import 'package:youtube/core/functions/handling_errors/api_result.dart';
import 'package:youtube/core/functions/handling_errors/network_exceptions.dart';
import 'package:youtube/core/utility/private_key.dart';
import 'package:youtube/data/data_sources/local/channnel/interfaces/cache_channel_playlist_apis.dart';

import 'package:youtube/data/data_sources/remote/api/channel/channel_playlist/channel_playlist_apis.dart';
import 'package:youtube/data/data_sources/remote/api/single_video/single_video_apis.dart';
import 'package:youtube/data/models/channel_details/playlists/playlist_videos/playlist_videos.dart';
import 'package:youtube/data/models/channel_details/playlists/playlists.dart';
import 'package:youtube/data/models/videos_details/videos_details.dart';
import 'package:youtube/domain/repositories/channel/channel_playlist_repository.dart';

class ChannelPlayListDetailsRepoImpl
    implements ChannelPlayListDetailsRepository {
  final ChannelPlayListAPIs _channelPlayListAPIs;
  final CacheChannelPlaylistAPIs _cacheChannelPlaylistAPIs;
  final SingleVideosAPIs _singleVideosAPIs;

  ChannelPlayListDetailsRepoImpl(this._channelPlayListAPIs,
      this._cacheChannelPlaylistAPIs, this._singleVideosAPIs);

  @override
  Future<void> clearChannelPlayLists({required String channelId}) async {
    await _cacheChannelPlaylistAPIs.clearChannelPlayLists(channelId: channelId);
  }

  @override
  Future<void> clearMyPlayLists() async {
    await _cacheChannelPlaylistAPIs.clearMyPlayLists();
  }

  @override
  Future<ApiResult<PlayLists>> getMyPlayLists() async {
    try {
      /// get from caching if it exist.
      PlayLists? cachedVideos =
          await _cacheChannelPlaylistAPIs.getMyPlayLists();
      if (cachedVideos != null) return ApiResult.success(cachedVideos);

      PlayLists playLists =
          await _channelPlayListAPIs.getMyPlayLists(accessToken: accessToken);

      /// caching videos
      await _cacheChannelPlaylistAPIs.saveMyPlayLists(playLists: playLists);

      return ApiResult.success(playLists);
    } catch (e) {
      return ApiResult.failure(NetworkExceptions.getDioException(e));
    }
  }

  @override
  Future<ApiResult<PlayLists>> getChannelPlayLists(
      {required String channelId}) async {
    try {
      /// get from caching if it exist.
      PlayLists? cachedVideos = await _cacheChannelPlaylistAPIs
          .getChannelPlayLists(channelId: channelId);
      if (cachedVideos != null) return ApiResult.success(cachedVideos);

      PlayLists playLists =
          await _channelPlayListAPIs.getChannelPlayLists(channelId: channelId);

      /// caching videos
      await _cacheChannelPlaylistAPIs.saveChannelPlayLists(
          channelId: channelId, playLists: playLists);

      return ApiResult.success(playLists);
    } catch (e) {
      return ApiResult.failure(NetworkExceptions.getDioException(e));
    }
  }

  @override
  Future<ApiResult<List<VideosDetails>>> getChannelPlayListItem(
      {required String playlistId}) async {
    try {
      PlayListVideos items =
          await _channelPlayListAPIs.getChannelPlayListItemsIds(
              playlistId: playlistId, accessToken: accessToken);

      List<VideosDetails> playlistVideos = [];

      for (final PlayListVideosItem? details
          in items.items ?? <PlayListVideosItem?>[]) {
        if (details?.videoId == null) continue;
        VideosDetails videos =
            await _singleVideosAPIs.getVideoDetails(videoId: details!.videoId!);
        int? length = videos.videoDetailsItem?.length;
        if (length != null && length > 0) playlistVideos.add(videos);
      }

      return ApiResult.success(playlistVideos);
    } catch (e) {
      return ApiResult.failure(NetworkExceptions.getDioException(e));
    }
  }
}
