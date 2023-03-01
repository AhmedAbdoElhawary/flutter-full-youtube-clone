part of '../interfaces/cache_channel_apis.dart';

const _cacheChannelKey = "CACHE_CHANNEL_KEY";

class CacheChannelAPIsImpl implements CacheChannelAPIs {
  Map<String, CachedItem<MySubscriptionsDetails>> cacheMap = {};

  @override
  Future<void> clearMySubscriptionsChannels() async {
    cacheMap.clear();
  }

  @override
  Future<MySubscriptionsDetails?> getMySubscriptionsChannels() async {
    CachedItem<MySubscriptionsDetails>? cachedItem = cacheMap[_cacheChannelKey];
    return cachedItem?.data;
  }

  @override
  Future<void> saveMySubscriptionsChannels(
      MySubscriptionsDetails subscriptions) async {
    cacheMap[_cacheChannelKey] =
        CachedItem<MySubscriptionsDetails>(subscriptions);

  }
}
