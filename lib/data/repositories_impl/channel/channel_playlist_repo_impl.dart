import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:youtube/core/functions/handling_errors/api_result.dart';
import 'package:youtube/core/functions/handling_errors/network_exceptions.dart';
import 'package:youtube/data/data_sources/local/channnel/interfaces/cache_channel_playlist_apis.dart';

import 'package:youtube/data/data_sources/remote/api/channel/channel_playlist/channel_playlist_apis.dart';
import 'package:youtube/data/data_sources/remote/api/single_video/single_video_apis.dart';
import 'package:youtube/data/models/channel_details/playlists/playlist_videos/playlist_videos.dart';
import 'package:youtube/data/models/channel_details/playlists/playlists.dart';
import 'package:youtube/data/models/channel_details/playlists/playlists_extension.dart';
import 'package:youtube/data/models/videos_details/videos_details.dart';
import 'package:youtube/domain/repositories/channel/channel_playlist_repository.dart';
import 'package:youtube/presentation/common_widgets/custom_blur_hash.dart';

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
  Future<ApiResult<PlayLists>> getChannelPlayLists(
      {required String channelId}) async {
    try {
      /// get from caching if it exist.
      PlayLists? cachedVideos = await _cacheChannelPlaylistAPIs
          .getChannelPlayLists(channelId: channelId);
      if (cachedVideos != null) return ApiResult.success(cachedVideos);

      PlayLists playLists =
          await _channelPlayListAPIs.getChannelPlayLists(channelId: channelId);

      playLists = await getBlurHashForPlaylists(playLists);

      /// caching videos
      await _cacheChannelPlaylistAPIs.saveChannelPlayLists(
          channelId: channelId, playLists: playLists);

      return ApiResult.success(playLists);
    } catch (e) {
      return ApiResult.failure(NetworkExceptions.getDioException(e));
    }
  }

  Future<PlayLists> getBlurHashForPlaylists(PlayLists playLists) async {
    for (final item in playLists.items ?? <PlayListsItem?>[]) {
      if (item == null) continue;
      String? url = item.getPlaylistCoverImageUrl();

      if (url == null) continue;
      Uint8List? image = await _networkImageToUnit8List(url);

      if (image == null) continue;
      String blurHash = await CustomBlurHash.blurHashEncode(image);
      item.blurHash = blurHash;
    }
    return playLists;
  }

  Future<Uint8List?> _networkImageToUnit8List(String imageUrl) async {
    final response = await Dio().get<List<int>>(imageUrl,
        options: Options(responseType: ResponseType.bytes));
    if (response.data != null) return Uint8List.fromList(response.data!);
    return null;
  }

  @override
  Future<ApiResult<List<VideosDetails>>> getChannelPlayListItem(
      {required String playlistId}) async {
    try {
      PlayListVideos items = await _channelPlayListAPIs
          .getChannelPlayListItemsIds(playlistId: playlistId);

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
