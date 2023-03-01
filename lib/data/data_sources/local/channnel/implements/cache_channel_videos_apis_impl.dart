part of '../interfaces/cache_channel_videos_apis.dart';

const _cacheMyChannelKey = "CACHE_MY_CHANNEL_KEY";

const _cacheAllChannelVideosKey = "CACHE_ALL_CHANNEL_VIDEOS_KEY";
const _cacheVideosOfThoseChannelsKey = "CACHE_VIDEOS_OF_THOSE_CHANNELS_KEY";
const _cacheAllChannelShortVideosKey = "CACHE_ALL_CHANNEL_SHORT_VIDEOS_KEY";
const _cacheAllPopularChannelVideosKey = "CACHE_ALL_POPULAR_CHANNEL_VIDEOS_KEY";
const _cacheAllPopularChannelShortVideosKey =
    "CACHE_ALL_POPULAR_CHANNEL_SHORT_VIDEOS_KEY";

class CacheChannelVideosAPIsImpl implements CacheChannelVideosAPIs {
  Map<String, Map<String, CachedItem<VideosDetails>>> cacheMap = {};

  @override
  void clearAllChannelShortVideos(
      {required String channelId, bool clearAll = false}) {
    if (clearAll) {
      cacheMap[_cacheAllChannelShortVideosKey]?.clear();
    } else {
      cacheMap[_cacheAllChannelShortVideosKey]?.remove(channelId);
    }
  }

  @override
  void clearAllChannelVideos(
      {required String channelId, bool clearAll = false}) {
    if (clearAll) {
      cacheMap[_cacheAllChannelVideosKey]?.clear();
    } else {
      cacheMap[_cacheAllChannelVideosKey]?.remove(channelId);
    }
  }

  @override
  void clearAllPopularChannelShortVideos(
      {required String channelId, bool clearAll = false}) {
    if (clearAll) {
      cacheMap[_cacheAllPopularChannelShortVideosKey]?.clear();
    } else {
      cacheMap[_cacheAllPopularChannelShortVideosKey]?.remove(channelId);
    }
  }

  @override
  void clearAllPopularChannelVideos(
      {required String channelId, bool clearAll = false}) {
    if (clearAll) {
      cacheMap[_cacheAllPopularChannelVideosKey]?.clear();
    } else {
      cacheMap[_cacheAllPopularChannelVideosKey]?.remove(channelId);
    }
  }

  @override
  void clearVideosOfThoseChannels() {
    cacheMap[_cacheVideosOfThoseChannelsKey]?.clear();
  }

  @override
  VideosDetails? getAllChannelShortVideos({required String channelId}) {
    CachedItem<VideosDetails>? cachedItem =
        cacheMap[_cacheAllChannelShortVideosKey]?[channelId];
    return cachedItem?.data;
  }

  @override
  VideosDetails? getAllChannelVideos({required String channelId}) {
    CachedItem<VideosDetails>? cachedItem =
        cacheMap[_cacheAllChannelVideosKey]?[channelId];
    return cachedItem?.data;
  }

  @override
  VideosDetails? getAllPopularChannelShortVideos({required String channelId}) {
    CachedItem<VideosDetails>? cachedItem =
        cacheMap[_cacheAllPopularChannelShortVideosKey]?[channelId];
    return cachedItem?.data;
  }

  @override
  VideosDetails? getAllPopularChannelVideos({required String channelId}) {
    CachedItem<VideosDetails>? cachedItem =
        cacheMap[_cacheAllPopularChannelVideosKey]?[channelId];
    return cachedItem?.data;
  }

  @override
  VideosDetails? getVideosOfThoseChannels() {
    CachedItem<VideosDetails>? cachedItem =
        cacheMap[_cacheVideosOfThoseChannelsKey]?[_cacheMyChannelKey];
    return cachedItem?.data;
  }

  @override
  void saveAllChannelShortVideos(
      {required String channelId, required VideosDetails videosDetails}) {
    cacheMap[_cacheAllChannelShortVideosKey]?[channelId] =
        CachedItem(videosDetails);
  }

  @override
  void saveAllChannelVideos(
      {required String channelId, required VideosDetails videosDetails}) {
    cacheMap[_cacheAllChannelVideosKey]?[channelId] = CachedItem(videosDetails);
  }

  @override
  void saveAllPopularChannelShortVideos(
      {required String channelId, required VideosDetails videosDetails}) {
    cacheMap[_cacheAllPopularChannelShortVideosKey]?[channelId] =
        CachedItem(videosDetails);
  }

  @override
  void saveAllPopularChannelVideos(
      {required String channelId, required VideosDetails videosDetails}) {
    cacheMap[_cacheAllPopularChannelVideosKey]?[channelId] =
        CachedItem(videosDetails);
  }

  @override
  void saveVideosOfThoseChannels({required VideosDetails videosDetails}) {
    cacheMap[_cacheVideosOfThoseChannelsKey]?[_cacheMyChannelKey] =
        CachedItem(videosDetails);
  }
}
