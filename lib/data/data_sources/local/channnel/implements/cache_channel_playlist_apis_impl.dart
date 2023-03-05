part of '../interfaces/cache_channel_playlist_apis.dart';

String _myPlaylistKey = "MY_PLAYLIST_KEY";

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

  @override
  Future<void> clearMyPlayLists() async {
    cacheMap.remove(_myPlaylistKey);
  }

  @override
  Future<PlayLists?> getMyPlayLists() async {
    CachedItem<PlayLists>? cachedItem = cacheMap[_myPlaylistKey];

    return cachedItem?.data;
  }

  @override
  Future<void> saveMyPlayLists({required PlayLists playLists}) async {
    cacheMap[_myPlaylistKey] = CachedItem(playLists);
  }
}
