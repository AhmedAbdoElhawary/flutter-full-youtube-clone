part of '../interfaces/cache_videos_apis.dart';

const _cacheMyVideosKey = "CACHE_MY_VIDEOS_KEY";

const _cacheAllVideosKey = "CACHE_ALL_VIDEOS_KEY";
const _cacheAllShortVideosKey = "CACHE_ALL_SHORT_VIDEOS_KEY";
const _cacheAllPopularVideosKey = "CACHE_ALL_POPULAR_VIDEOS_KEY";

class CacheVideosAPIsImpl implements CacheVideosAPIs {
  Map<String, Map<String, CachedItem<VideosDetails>>> cacheMap = {};

  @override
  Future<void> clearAllVideos() async {
    cacheMap[_cacheAllVideosKey]?.clear();
  }

  @override
  Future<void> clearAllShortVideos() async {
    cacheMap[_cacheAllShortVideosKey]?.clear();
  }

  @override
  Future<void> clearAllPopularVideos(
      {required String videoCategoryId, bool clearAll = false}) async {
    if (clearAll) {
      cacheMap[_cacheAllPopularVideosKey]?.clear();
    } else {
      cacheMap[_cacheAllPopularVideosKey]?.remove(videoCategoryId);
    }
  }

  @override
  Future<VideosDetails?> getAllVideos() async {
    if (!cacheMap.containsKey(_cacheAllVideosKey) ||
        !cacheMap[_cacheAllVideosKey]!.containsKey(_cacheMyVideosKey)) {
      return null;
    }

    CachedItem<VideosDetails>? cachedItem =
        cacheMap[_cacheAllVideosKey]![_cacheMyVideosKey];
    return cachedItem?.data;
  }

  @override
  Future<VideosDetails?> getAllShortVideos() async {
    if (!cacheMap.containsKey(_cacheAllShortVideosKey) ||
        !cacheMap[_cacheAllShortVideosKey]!.containsKey(_cacheMyVideosKey)) {
      return null;
    }

    CachedItem<VideosDetails>? cachedItem =
        cacheMap[_cacheAllShortVideosKey]![_cacheMyVideosKey];
    return cachedItem?.data;
  }

  @override
  Future<VideosDetails?> getAllPopularVideos(String videoCategoryId) async {
    if (!cacheMap.containsKey(_cacheAllPopularVideosKey) ||
        !cacheMap[_cacheAllPopularVideosKey]!.containsKey(videoCategoryId)) {
      return null;
    }

    CachedItem<VideosDetails>? cachedItem =
        cacheMap[_cacheAllPopularVideosKey]![videoCategoryId];
    return cachedItem?.data;
  }

  @override
  Future<void> saveAllVideos({required VideosDetails videosDetails}) async {
    if (!cacheMap.containsKey(_cacheAllVideosKey)) {
      cacheMap[_cacheAllVideosKey] = {};
    }

    if (!cacheMap[_cacheAllVideosKey]!.containsKey(_cacheMyVideosKey)) {
      cacheMap[_cacheAllVideosKey]![_cacheMyVideosKey] =
          CachedItem(videosDetails);
    } else {
      cacheMap[_cacheAllVideosKey]![_cacheMyVideosKey]!.data = videosDetails;
    }
  }

  @override
  Future<void> saveAllShortVideos(
      {required VideosDetails videosDetails}) async {
    if (!cacheMap.containsKey(_cacheAllShortVideosKey)) {
      cacheMap[_cacheAllShortVideosKey] = {};
    }

    cacheMap[_cacheAllShortVideosKey]![_cacheMyVideosKey] =
        CachedItem(videosDetails);
  }

  @override
  Future<void> saveAllPopularVideos({
    required String videoCategoryId,
    required VideosDetails videosDetails,
  }) async {
    if (!cacheMap.containsKey(_cacheAllPopularVideosKey)) {
      cacheMap[_cacheAllPopularVideosKey] = {};
    }

    cacheMap[_cacheAllPopularVideosKey]![videoCategoryId] =
        CachedItem(videosDetails);
  }
}
