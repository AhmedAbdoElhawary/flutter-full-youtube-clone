part of '../interfaces/cache_channel_apis.dart';


const _cacheChannelKey = "CACHE_CHANNEL_KEY";

class CacheChannelAPIsImpl implements CacheChannelAPIs {
  Map<String, CachedItem<MySubscriptionsDetails>> cacheMap = {};

  @override
  void clearMySubscriptionsChannels() {
    cacheMap.clear();
  }

  @override
  MySubscriptionsDetails? getMySubscriptionsChannels() {
    CachedItem<MySubscriptionsDetails>? cachedItem = cacheMap[_cacheChannelKey];
    return cachedItem?.data;
  }

  @override
  void saveMySubscriptionsChannels(MySubscriptionsDetails subscriptions) {
    cacheMap[_cacheChannelKey] =
        CachedItem<MySubscriptionsDetails>(subscriptions);
  }
}
