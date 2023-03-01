import 'package:youtube/data/models/videos_details/videos_details.dart';

import '../../../../../domain/entities/cache_items/cached_item.dart';

part '../implements/cache_channel_videos_apis_impl.dart';

abstract class CacheChannelVideosAPIs {
  Future<VideosDetails?> getAllChannelVideos({required String channelId});
  Future<List<VideosDetails>?> getVideosOfThoseChannels();
  Future<VideosDetails?> getAllChannelShortVideos({required String channelId});
  Future<VideosDetails?> getAllPopularChannelVideos({required String channelId});
  Future<VideosDetails?> getAllPopularChannelShortVideos({required String channelId});

  Future<void> saveAllChannelVideos(
      {required String channelId, required VideosDetails videosDetails});
  Future<void> saveVideosOfThoseChannels({required List<VideosDetails> videosDetails});
  Future<void> saveAllChannelShortVideos(
      {required String channelId, required VideosDetails videosDetails});
  Future<void> saveAllPopularChannelVideos(
      {required String channelId, required VideosDetails videosDetails});
  Future<void> saveAllPopularChannelShortVideos(
      {required String channelId, required VideosDetails videosDetails});

  Future<void> clearAllChannelVideos(
      {required String channelId, bool clearAll = false});
  Future<void> clearVideosOfThoseChannels();
  Future<void> clearAllChannelShortVideos(
      {required String channelId, bool clearAll = false});
  Future<void> clearAllPopularChannelVideos(
      {required String channelId, bool clearAll = false});
  Future<void> clearAllPopularChannelShortVideos(
      {required String channelId, bool clearAll = false});
}
