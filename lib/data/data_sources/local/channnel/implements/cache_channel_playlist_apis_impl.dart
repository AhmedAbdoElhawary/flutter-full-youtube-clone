part of '../interfaces/cache_channel_playlist_apis.dart';

class CacheChannelPlaylistAPIsImpl implements CacheChannelPlaylistAPIs {
  Map<String, CachedItem<PlayLists>> cacheMap = {};

  @override
  void clearChannelPlayLists({required String channelId}) {
    cacheMap.remove(channelId);
  }

  @override
  PlayLists? getChannelPlayLists({required String channelId}) {
    CachedItem<PlayLists>? cachedItem = cacheMap[channelId];
    return cachedItem?.data;
  }

  @override
  void saveChannelPlayLists(
      {required String channelId, required PlayLists playLists}) {
    cacheMap[channelId] = CachedItem(playLists);
  }
}
