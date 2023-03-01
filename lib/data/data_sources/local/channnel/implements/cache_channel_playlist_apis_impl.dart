part of '../interfaces/cache_channel_playlist_apis.dart';

class CacheChannelPlaylistAPIsImpl implements CacheChannelPlaylistAPIs {
  Map<String, CachedItem<PlayLists>> cacheMap = {};

  @override
  Future<void> clearChannelPlayLists({required String channelId}) async {
    cacheMap.remove(channelId);
  }

  @override
  Future<PlayLists?> getChannelPlayLists({required String channelId}) async {

    CachedItem<PlayLists>? cachedItem = cacheMap[channelId];

    return cachedItem?.data;
  }

  @override
  Future<void> saveChannelPlayLists(
      {required String channelId, required PlayLists playLists}) async {
    cacheMap[channelId] = CachedItem(playLists);

  }
}
