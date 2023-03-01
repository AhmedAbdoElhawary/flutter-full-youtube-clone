import 'package:youtube/data/models/videos_details/videos_details.dart';

import '../../../../../domain/entities/cache_items/cached_item.dart';

part '../implements/cache_channel_videos_apis_impl.dart';

abstract class CacheChannelVideosAPIs {
  VideosDetails? getAllChannelVideos({required String channelId});
  VideosDetails? getVideosOfThoseChannels();
  VideosDetails? getAllChannelShortVideos({required String channelId});
  VideosDetails? getAllPopularChannelVideos({required String channelId});
  VideosDetails? getAllPopularChannelShortVideos({required String channelId});

  void saveAllChannelVideos(
      {required String channelId, required VideosDetails videosDetails});
  void saveVideosOfThoseChannels({required VideosDetails videosDetails});
  void saveAllChannelShortVideos(
      {required String channelId, required VideosDetails videosDetails});
  void saveAllPopularChannelVideos(
      {required String channelId, required VideosDetails videosDetails});
  void saveAllPopularChannelShortVideos(
      {required String channelId, required VideosDetails videosDetails});

  void clearAllChannelVideos(
      {required String channelId, bool clearAll = false});
  void clearVideosOfThoseChannels();
  void clearAllChannelShortVideos(
      {required String channelId, bool clearAll = false});
  void clearAllPopularChannelVideos(
      {required String channelId, bool clearAll = false});
  void clearAllPopularChannelShortVideos(
      {required String channelId, bool clearAll = false});
}
