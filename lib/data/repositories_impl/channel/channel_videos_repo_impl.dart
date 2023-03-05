import 'package:youtube/core/functions/handling_errors/api_result.dart';
import 'package:youtube/core/functions/handling_errors/network_exceptions.dart';
import 'package:youtube/data/data_sources/local/channnel/interfaces/cache_channel_videos_apis.dart';

import 'package:youtube/data/data_sources/remote/api/channel/channel_videos/channel_videos_apis.dart';
import 'package:youtube/data/models/channel_details/my_subscriptions/my_subscription_item_extension.dart';
import 'package:youtube/data/models/channel_details/my_subscriptions/my_subscriptions_details.dart';
import 'package:youtube/data/models/searched_video_details/searched_video_details.dart';
import 'package:youtube/data/models/videos_details/videos_details.dart';
import 'package:youtube/domain/repositories/channel/channel_videos_repository.dart';
import 'package:youtube/domain/repositories/videos_details_repository.dart';

class ChannelVideosDetailsRepoImpl implements ChannelVideosDetailsRepository {
  final ChannelVideosAPIs _channelVideosAPIs;
  final VideosDetailsRepository _videosDetailsRepository;

  final CacheChannelVideosAPIs _cacheChannelVideosAPIs;
  ChannelVideosDetailsRepoImpl(this._channelVideosAPIs,
      this._videosDetailsRepository, this._cacheChannelVideosAPIs);

  @override
  Future<ApiResult<VideosDetails>> getAllChannelShortVideos(
      {required String channelId}) async {
    try {
      /// get from caching if it exist.
      VideosDetails? cachedVideos = await _cacheChannelVideosAPIs
          .getAllChannelShortVideos(channelId: channelId);
      if (cachedVideos != null) return ApiResult.success(cachedVideos);

      SearchedVideosDetails shortVideosIds = await _channelVideosAPIs
          .getAllChannelShortVideosIds(channelId: channelId);

      VideosDetails completeVideosDetails = await _videosDetailsRepository
          .getCompleteVideosDetailsOfThoseIds(shortVideosIds);

      /// caching videos
      await _cacheChannelVideosAPIs.saveAllChannelShortVideos(
          channelId: channelId, videosDetails: completeVideosDetails);

      return ApiResult.success(completeVideosDetails);
    } catch (e) {
      return ApiResult.failure(NetworkExceptions.getDioException(e));
    }
  }

  @override
  Future<ApiResult<VideosDetails>> getAllChannelVideos(
      {required String channelId}) async {
    try {
      /// get from caching if it exist.
      VideosDetails? cachedVideos = await _cacheChannelVideosAPIs
          .getAllChannelVideos(channelId: channelId);
      if (cachedVideos != null) return ApiResult.success(cachedVideos);

      SearchedVideosDetails videosIds =
          await _channelVideosAPIs.getAllChannelVideosIds(channelId: channelId);

      VideosDetails completeVideosDetails = await _videosDetailsRepository
          .getCompleteVideosDetailsOfThoseIds(videosIds);

      /// caching videos
      await _cacheChannelVideosAPIs.saveAllChannelVideos(
          channelId: channelId, videosDetails: completeVideosDetails);

      return ApiResult.success(completeVideosDetails);
    } catch (e) {
      return ApiResult.failure(NetworkExceptions.getDioException(e));
    }
  }

  @override
  Future<ApiResult<VideosDetails>> getAllPopularChannelShortVideos(
      {required String channelId}) async {
    try {
      /// get from caching if it exist.
      VideosDetails? cachedVideos = await _cacheChannelVideosAPIs
          .getAllPopularChannelShortVideos(channelId: channelId);
      if (cachedVideos != null) return ApiResult.success(cachedVideos);

      SearchedVideosDetails shortVideosIds =
          await _channelVideosAPIs.getAllChannelShortVideosIds(
              channelId: channelId, orderVideos: "viewCount");

      VideosDetails completeVideosDetails = await _videosDetailsRepository
          .getCompleteVideosDetailsOfThoseIds(shortVideosIds);

      /// caching videos
      await _cacheChannelVideosAPIs.saveAllPopularChannelShortVideos(
          channelId: channelId, videosDetails: completeVideosDetails);

      return ApiResult.success(completeVideosDetails);
    } catch (e) {
      return ApiResult.failure(NetworkExceptions.getDioException(e));
    }
  }

  @override
  Future<ApiResult<VideosDetails>> getAllPopularChannelVideos(
      {required String channelId}) async {
    try {
      /// get from caching if it exist.
      VideosDetails? cachedVideos = await _cacheChannelVideosAPIs
          .getAllPopularChannelVideos(channelId: channelId);
      if (cachedVideos != null) return ApiResult.success(cachedVideos);

      SearchedVideosDetails videosIds =
          await _channelVideosAPIs.getAllChannelVideosIds(
              channelId: channelId, orderVideos: "viewCount");

      VideosDetails completeVideosDetails = await _videosDetailsRepository
          .getCompleteVideosDetailsOfThoseIds(videosIds);

      /// caching videos
      await _cacheChannelVideosAPIs.saveAllPopularChannelVideos(
          channelId: channelId, videosDetails: completeVideosDetails);

      return ApiResult.success(completeVideosDetails);
    } catch (e) {
      return ApiResult.failure(NetworkExceptions.getDioException(e));
    }
  }

  @override
  Future<ApiResult<List<VideosDetails>>> getVideosOfThoseChannels(
      {required MySubscriptionsDetails mySubscriptionsDetails}) async {
    try {
      /// get from caching if it exist.
      List<VideosDetails>? cachedVideos =
          await _cacheChannelVideosAPIs.getVideosOfThoseChannels();
      if (cachedVideos != null) return ApiResult.success(cachedVideos);

      List<MySubscriptionsItem?>? item = mySubscriptionsDetails.items;
      List<VideosDetails> channelsVideosDetails = [];
      for (final channelDetails in item ?? <MySubscriptionsItem>[]) {
        SearchedVideosDetails videosIds =
            await _channelVideosAPIs.getAllChannelVideosIds(
                channelId: channelDetails?.getChannelId() ?? "");

        VideosDetails videosWithSubChannelDetails =
            await _videosDetailsRepository
                .getCompleteVideosDetailsOfThoseIds(videosIds);

        channelsVideosDetails.add(videosWithSubChannelDetails);
      }

      /// caching videos
      await _cacheChannelVideosAPIs.saveVideosOfThoseChannels(
          videosDetails: channelsVideosDetails);

      return ApiResult.success(channelsVideosDetails);
    } catch (e) {
      return ApiResult.failure(NetworkExceptions.getDioException(e));
    }
  }

  @override
  Future<void> clearAllChannelShortVideos(
      {required String channelId, required bool clearAll}) async {
    await _cacheChannelVideosAPIs.clearAllChannelShortVideos(
        channelId: channelId, clearAll: clearAll);
  }

  @override
  Future<void> clearAllChannelVideos(
      {required String channelId, required bool clearAll}) async {
    await _cacheChannelVideosAPIs.clearAllChannelVideos(
        channelId: channelId, clearAll: clearAll);
  }

  @override
  Future<void> clearAllPopularChannelShortVideos(
      {required String channelId, required bool clearAll}) async {
    await _cacheChannelVideosAPIs.clearAllPopularChannelShortVideos(
        channelId: channelId, clearAll: clearAll);
  }

  @override
  Future<void> clearAllPopularChannelVideos(
      {required String channelId, required bool clearAll}) async {
    await _cacheChannelVideosAPIs.clearAllPopularChannelVideos(
        channelId: channelId, clearAll: clearAll);
  }

  @override
  Future<void> clearVideosOfThoseChannels() async {
    await _cacheChannelVideosAPIs.clearVideosOfThoseChannels();
  }
}
