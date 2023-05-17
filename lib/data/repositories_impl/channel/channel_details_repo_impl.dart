import 'package:youtube/core/helpers/handling_errors/api_result.dart';
import 'package:youtube/core/helpers/handling_errors/network_exceptions.dart';

import 'package:youtube/core/utility/private_key.dart';
import 'package:youtube/data/data_sources/local/channnel/interfaces/cache_channel_apis.dart';
import 'package:youtube/data/data_sources/remote/api/channel/channel_apis.dart';
import 'package:youtube/data/models/channel_details/channel_details.dart';
import 'package:youtube/data/models/channel_details/my_subscriptions/my_subscriptions_details.dart';
import 'package:youtube/data/models/channel_details/subscribe_request_body.dart';
import 'package:youtube/data/models/videos_details/videos_details.dart';
import 'package:youtube/domain/repositories/channel/channel_details_repository.dart';

class ChannelDetailsRepoImpl implements ChannelDetailsRepository {
  final ChannelAPIs _channelAPIs;
  final CacheChannelAPIs _cacheChannelAPIs;
  ChannelDetailsRepoImpl(this._channelAPIs, this._cacheChannelAPIs);

  @override
  Future<ApiResult<ChannelSubDetails>> getSubSingleChannelDetails(
      {required String channelId}) async {
    try {
      ChannelSubDetails channelSubDetails =
          await _channelAPIs.getSubChannelInfo(channelId: channelId);
      return ApiResult.success(channelSubDetails);
    } catch (e) {
      return ApiResult.failure(NetworkExceptions.getDioException(e));
    }
  }

  @override
  Future<ApiResult<void>> subscribeToChannel(
      {required String channelId}) async {
    try {
      await _channelAPIs.subscribeToChannel(
          accessToken: accessToken,
          body: SubscriptionRequestBody.toJson(channelId));
      return const ApiResult.success(null);
    } catch (e) {
      return ApiResult.failure(NetworkExceptions.getDioException(e));
    }
  }

  @override
  Future<ApiResult<void>> deleteSubscription(String subscriptionId) async {
    try {
      await _channelAPIs.deleteSubscription(
          accessToken: accessToken, id: subscriptionId);
      return const ApiResult.success(null);
    } catch (e) {
      return ApiResult.failure(NetworkExceptions.getDioException(e));
    }
  }

  @override
  Future<VideosDetails> getSubChannelsDetails(
      {required VideosDetails videosDetails}) async {
    try {
      for (final item
          in videosDetails.videoDetailsItem ?? <VideoDetailsItem>[]) {
        String channelId = item.snippet?.channelId ?? "";
        ChannelSubDetails subChannelDetails =
            await _channelAPIs.getSubChannelInfo(channelId: channelId);

        item.snippet?.channelSubDetails = subChannelDetails;
      }
      return videosDetails;
    } catch (e) {
      return Future.error(e);
    }
  }

  @override
  Future<ApiResult<MySubscriptionsDetails>> getMySubscriptionsChannels() async {
    try {
      /// get from caching if it exist.
      MySubscriptionsDetails? channels =
          await _cacheChannelAPIs.getMySubscriptionsChannels();
      if (channels != null) return ApiResult.success(channels);

      MySubscriptionsDetails mySubscriptions = await _channelAPIs
          .getMySubscriptionsChannels(accessToken: accessToken);

      /// caching videos
      await _cacheChannelAPIs.saveMySubscriptionsChannels(mySubscriptions);

      return ApiResult.success(mySubscriptions);
    } catch (e) {
      return ApiResult.failure(NetworkExceptions.getDioException(e));
    }
  }

  @override
  Future<void> clearMySubscriptionsChannels() async {
    await _cacheChannelAPIs.clearMySubscriptionsChannels();
  }

  @override
  Future<ApiResult<ChannelSubDetails>> getMyChannelInfo() async {
    try {
      /// get from caching if it exist.
      ChannelSubDetails? channels = await _cacheChannelAPIs.getMyChannelInfo();
      if (channels != null) return ApiResult.success(channels);

      ChannelSubDetails myInfo =
          await _channelAPIs.getMyChannelInfo(accessToken: accessToken);

      /// caching videos
      await _cacheChannelAPIs.saveMyChannelInfo(myInfo);

      return ApiResult.success(myInfo);
    } catch (e) {
      return ApiResult.failure(NetworkExceptions.getDioException(e));
    }
  }

  @override
  Future<void> clearMyChannelInfo() async {
    await _cacheChannelAPIs.clearMyChannelInfo();
  }
}
