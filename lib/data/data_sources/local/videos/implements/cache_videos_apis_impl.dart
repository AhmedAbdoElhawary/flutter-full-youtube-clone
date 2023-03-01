part of '../interfaces/cache_videos_apis.dart';

const _cacheMyVideosKey = "CACHE_MY_VIDEOS_KEY";

const _cacheAllVideosKey = "CACHE_ALL_VIDEOS_KEY";
const _cacheAllShortVideosKey = "CACHE_ALL_SHORT_VIDEOS_KEY";
const _cacheAllPopularVideosKey = "CACHE_ALL_POPULAR_VIDEOS_KEY";

class CacheChannelVideosAPIsImpl implements CacheVideosAPIs {
  Map<String, Map<String, CachedItem<VideosDetails>>> cacheMap = {};
  @override
  void clearAllVideos() {
    cacheMap[_cacheAllVideosKey]?.clear();
  }

  @override
  void clearAllShortVideos() {
    cacheMap[_cacheAllShortVideosKey]?.clear();
  }

  @override
  void clearAllPopularVideos(
      {required String videoCategoryId, bool clearAll = false}) {
    if (clearAll) {
      cacheMap[_cacheAllPopularVideosKey]?.clear();
    } else {
      cacheMap[_cacheAllPopularVideosKey]?.remove(videoCategoryId);
    }
  }

  @override
  VideosDetails? getAllShortVideos() {
    CachedItem<VideosDetails>? cachedItem =
        cacheMap[_cacheAllShortVideosKey]?[_cacheMyVideosKey];
    return cachedItem?.data;
  }

  @override
  VideosDetails? getAllVideos() {
    CachedItem<VideosDetails>? cachedItem =
        cacheMap[_cacheAllVideosKey]?[_cacheMyVideosKey];
    return cachedItem?.data;
  }

  @override
  VideosDetails? getAllPopularVideos(String videoCategoryId) {
    CachedItem<VideosDetails>? cachedItem =
        cacheMap[_cacheAllPopularVideosKey]?[videoCategoryId];
    return cachedItem?.data;
  }

  @override
  void saveAllShortVideos({required VideosDetails videosDetails}) {
    cacheMap[_cacheAllShortVideosKey]?[_cacheMyVideosKey] =
        CachedItem(videosDetails);
  }

  @override
  void saveAllVideos({required VideosDetails videosDetails}) {
    cacheMap[_cacheAllVideosKey]?[_cacheMyVideosKey] =
        CachedItem(videosDetails);
  }

  @override
  void saveAllPopularVideos(
      {required String videoCategoryId, required VideosDetails videosDetails}) {
    cacheMap[_cacheAllPopularVideosKey]?[videoCategoryId] =
        CachedItem(videosDetails);
  }
}
