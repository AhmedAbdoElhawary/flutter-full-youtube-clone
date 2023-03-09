import 'package:youtube/core/functions/handling_errors/api_result.dart';
import 'package:youtube/data/models/channel_details/channel_details.dart';
import 'package:youtube/data/models/channel_details/my_subscriptions/my_subscriptions_details.dart';
import 'package:youtube/data/models/videos_details/videos_details.dart';

abstract class ChannelDetailsRepository {
  Future<ApiResult<ChannelSubDetails>> getSubSingleChannelDetails(
      {required String channelId});
  Future<VideosDetails> getSubChannelsDetails(
      {required VideosDetails videosDetails});
  Future<ApiResult<void>> subscribeToChannel({required String channelId});
  Future<ApiResult<void>> deleteSubscription(String subscriptionId);
  Future<ApiResult<MySubscriptionsDetails>> getMySubscriptionsChannels();
  Future<ApiResult<ChannelSubDetails>> getMyChannelInfo();
  Future<void> clearMySubscriptionsChannels();
  Future<void> clearMyChannelInfo();

}
