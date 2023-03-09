part of '../interfaces/cache_channel_apis.dart';

const _cacheChannelKey = "CACHE_CHANNEL_KEY";
const _cacheMyChannelKey = "CACHE_MY_CHANNEL_KEY";

class CacheChannelAPIsImpl implements CacheChannelAPIs {
  Map<String, CachedItem<dynamic>> cacheMap = {};

  @override
  Future<void> clearMySubscriptionsChannels() async {
    cacheMap.remove(_cacheChannelKey);
  }

  @override
  Future<void> clearMyChannelInfo() async {
    cacheMap.remove(_cacheMyChannelKey);
  }

  @override
  Future<MySubscriptionsDetails?> getMySubscriptionsChannels() async {
    CachedItem<MySubscriptionsDetails>? cachedItem =
        cacheMap[_cacheChannelKey] as CachedItem<MySubscriptionsDetails>?;
    return cachedItem?.data;
  }

  @override
  Future<ChannelSubDetails?> getMyChannelInfo() async {
    CachedItem<ChannelSubDetails>? cachedItem =
        cacheMap[_cacheMyChannelKey] as CachedItem<ChannelSubDetails>?;
    return cachedItem?.data;
  }

  @override
  Future<void> saveMySubscriptionsChannels(
      MySubscriptionsDetails subscriptions) async {
    cacheMap[_cacheChannelKey] =
        CachedItem<MySubscriptionsDetails>(subscriptions);
  }

  @override
  Future<void> saveMyChannelInfo(ChannelSubDetails details) async {
    cacheMap[_cacheMyChannelKey] = CachedItem<ChannelSubDetails>(details);
  }
}
