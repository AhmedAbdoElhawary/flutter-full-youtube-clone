import 'package:youtube/core/helpers/handling_errors/api_result.dart';
import 'package:youtube/data/models/channel_details/my_subscriptions/my_subscriptions_details.dart';
import 'package:youtube/data/models/videos_details/videos_details.dart';

abstract class ChannelVideosDetailsRepository {
  Future<ApiResult<VideosDetails>> getAllChannelVideos({
    required String channelId,
  });
  Future<ApiResult<List<VideosDetails>>> getVideosOfThoseChannels({
    required MySubscriptionsDetails mySubscriptionsDetails,
  });

  Future<ApiResult<VideosDetails>> getAllChannelShortVideos({
    required String channelId,
  });
  Future<ApiResult<VideosDetails>> getAllPopularChannelVideos({
    required String channelId,
  });

  Future<ApiResult<VideosDetails>> getAllPopularChannelShortVideos({
    required String channelId,
  });

  Future<void> clearAllChannelVideos(
      {required String channelId, required bool clearAll});
  Future<void> clearVideosOfThoseChannels();
  Future<void> clearAllChannelShortVideos(
      {required String channelId, required bool clearAll});
  Future<void> clearAllPopularChannelVideos(
      {required String channelId, required bool clearAll});
  Future<void> clearAllPopularChannelShortVideos(
      {required String channelId, required bool clearAll});
}
