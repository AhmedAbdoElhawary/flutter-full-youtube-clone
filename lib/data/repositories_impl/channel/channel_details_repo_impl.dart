import 'package:youtube/core/functions/api_result.dart';
import 'package:youtube/core/functions/network_exceptions.dart';

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
          _cacheChannelAPIs.getMySubscriptionsChannels();
      if (channels != null) return ApiResult.success(channels);

      MySubscriptionsDetails mySubscriptions = await _channelAPIs
          .getMySubscriptionsChannels(accessToken: accessToken);

      /// caching videos
      _cacheChannelAPIs.saveMySubscriptionsChannels(mySubscriptions);

      return ApiResult.success(mySubscriptions);
    } catch (e) {
      return ApiResult.failure(NetworkExceptions.getDioException(e));
    }
  }

  @override
  void clearMySubscriptionsChannels() {
    _cacheChannelAPIs.clearMySubscriptionsChannels();
  }
}
