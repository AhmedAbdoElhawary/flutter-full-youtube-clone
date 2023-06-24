part of '../interfaces/cache_channel_videos_apis.dart';

const _cacheMyChannelKey = "CACHE_MY_CHANNEL_KEY";

const _cacheAllChannelVideosKey = "CACHE_ALL_CHANNEL_VIDEOS_KEY";
const _cacheVideosOfThoseChannelsKey = "CACHE_VIDEOS_OF_THOSE_CHANNELS_KEY";
const _cacheAllChannelShortVideosKey = "CACHE_ALL_CHANNEL_SHORT_VIDEOS_KEY";
const _cacheAllPopularChannelVideosKey = "CACHE_ALL_POPULAR_CHANNEL_VIDEOS_KEY";
const _cacheAllPopularChannelShortVideosKey =
    "CACHE_ALL_POPULAR_CHANNEL_SHORT_VIDEOS_KEY";

class CacheChannelVideosAPIsImpl implements CacheChannelVideosAPIs {
  Map<String, Map<String, CachedItem<dynamic>>> cacheMap = {};

  @override
  Future<void> clearAllChannelShortVideos(
      {required String channelId, bool clearAll = false}) async {
    if (clearAll) {
      cacheMap[_cacheAllChannelShortVideosKey]?.clear();
    } else {
      cacheMap[_cacheAllChannelShortVideosKey]?.remove(channelId);
    }
  }

  @override
  Future<void> clearAllChannelVideos(
      {required String channelId, bool clearAll = false}) async {
    if (clearAll) {
      cacheMap[_cacheAllChannelVideosKey]?.clear();
    } else {
      cacheMap[_cacheAllChannelVideosKey]?.remove(channelId);
    }
  }

  @override
  Future<void> clearAllPopularChannelShortVideos(
      {required String channelId, bool clearAll = false}) async {
    if (clearAll) {
      cacheMap[_cacheAllPopularChannelShortVideosKey]?.clear();
    } else {
      cacheMap[_cacheAllPopularChannelShortVideosKey]?.remove(channelId);
    }
  }

  @override
  Future<void> clearAllPopularChannelVideos(
      {required String channelId, bool clearAll = false}) async {
    if (clearAll) {
      cacheMap[_cacheAllPopularChannelVideosKey]?.clear();
    } else {
      cacheMap[_cacheAllPopularChannelVideosKey]?.remove(channelId);
    }
  }

  @override
  Future<void> clearVideosOfThoseChannels() async {
    cacheMap[_cacheVideosOfThoseChannelsKey]?.clear();
  }

  @override
  Future<VideosDetails?> getAllChannelShortVideos(
      {required String channelId}) async {
    CachedItem<VideosDetails>? cachedItem =
        cacheMap[_cacheAllChannelShortVideosKey]?[channelId]
            as CachedItem<VideosDetails>?;

    return cachedItem?.data;
  }

  @override
  Future<VideosDetails?> getAllChannelVideos(
      {required String channelId}) async {
    CachedItem<VideosDetails>? cachedItem = cacheMap[_cacheAllChannelVideosKey]
        ?[channelId] as CachedItem<VideosDetails>?;

    return cachedItem?.data;
  }

  @override
  Future<VideosDetails?> getAllPopularChannelShortVideos(
      {required String channelId}) async {
    CachedItem<VideosDetails>? cachedItem =
        cacheMap[_cacheAllPopularChannelShortVideosKey]?[channelId]
            as CachedItem<VideosDetails>?;

    return cachedItem?.data;
  }

  @override
  Future<VideosDetails?> getAllPopularChannelVideos(
      {required String channelId}) async {
    CachedItem<VideosDetails>? cachedItem =
        cacheMap[_cacheAllPopularChannelVideosKey]?[channelId]
            as CachedItem<VideosDetails>?;

    return cachedItem?.data;
  }

  @override
  Future<List<VideosDetails>?> getVideosOfThoseChannels() async {
    if (!cacheMap.containsKey(_cacheVideosOfThoseChannelsKey) ||
        !cacheMap[_cacheVideosOfThoseChannelsKey]!
            .containsKey(_cacheMyChannelKey)) {
      return null;
    }

    CachedItem<List<VideosDetails>>? cachedItem =
        cacheMap[_cacheVideosOfThoseChannelsKey]?[_cacheMyChannelKey]
            as CachedItem<List<VideosDetails>>?;
    return cachedItem?.data;
  }

  @override
  Future<void> saveAllChannelShortVideos(
      {required String channelId, required VideosDetails videosDetails}) async {
    if (!cacheMap.containsKey(_cacheAllChannelShortVideosKey)) {
      cacheMap[_cacheAllChannelShortVideosKey] = {};
    }

    cacheMap[_cacheAllChannelShortVideosKey]![channelId] =
        CachedItem<VideosDetails>(videosDetails);
  }

  @override
  Future<void> saveAllChannelVideos(
      {required String channelId, required VideosDetails videosDetails}) async {
    if (!cacheMap.containsKey(_cacheAllChannelVideosKey)) {
      cacheMap[_cacheAllChannelVideosKey] = {};
    }

    cacheMap[_cacheAllChannelVideosKey]![channelId] =
        CachedItem<VideosDetails>(videosDetails);
  }

  @override
  Future<void> saveAllPopularChannelShortVideos(
      {required String channelId, required VideosDetails videosDetails}) async {
    if (!cacheMap.containsKey(_cacheAllPopularChannelShortVideosKey)) {
      cacheMap[_cacheAllPopularChannelShortVideosKey] = {};
    }

    cacheMap[_cacheAllPopularChannelShortVideosKey]![channelId] =
        CachedItem<VideosDetails>(videosDetails);
  }

  @override
  Future<void> saveAllPopularChannelVideos(
      {required String channelId, required VideosDetails videosDetails}) async {
    if (!cacheMap.containsKey(_cacheAllPopularChannelVideosKey)) {
      cacheMap[_cacheAllPopularChannelVideosKey] = {};
    }

    cacheMap[_cacheAllPopularChannelVideosKey]?[channelId] =
        CachedItem<VideosDetails>(videosDetails);
  }

  @override
  Future<void> saveVideosOfThoseChannels(
      {required List<VideosDetails> videosDetails}) async {
    if (!cacheMap.containsKey(_cacheVideosOfThoseChannelsKey)) {
      cacheMap[_cacheVideosOfThoseChannelsKey] = {};
    }

    cacheMap[_cacheVideosOfThoseChannelsKey]?[_cacheMyChannelKey] =
        CachedItem<List<VideosDetails>>(videosDetails);
  }
}
