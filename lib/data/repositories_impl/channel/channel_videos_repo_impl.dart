import 'package:youtube/core/functions/api_result.dart';

import 'package:youtube/data/data_sources/remote/api/channel/channel_videos/channel_videos_apis.dart';
import 'package:youtube/data/models/common/videos_ids/videos_ids.dart';
import 'package:youtube/data/models/videos_details/videos_details.dart';
import 'package:youtube/domain/repositories/channel/channel_videos_repository.dart';
import 'package:youtube/domain/repositories/videos_details_repository.dart';

class ChannelVideosDetailsRepoImpl implements ChannelVideosDetailsRepository {
  final ChannelVideosAPIs _channelVideosAPIs;
  final VideosDetailsRepository _videosDetailsRepository;

  ChannelVideosDetailsRepoImpl(
      this._channelVideosAPIs, this._videosDetailsRepository);

  @override
  Future<ApiResult<VideosDetails>> getAllChannelShortVideos(
      {required String channelId}) async {
    try {
      VideosIdsDetails shortVideosIds = await _channelVideosAPIs
          .getAllChannelShortVideosIds(channelId: channelId);

      VideosDetails videosWithSubChannelDetails = await _videosDetailsRepository
          .getCompleteVideosDetailsOfThoseIds(shortVideosIds);

      return ApiResult.success(videosWithSubChannelDetails);
    } catch (e) {
      return ApiResult.failure(e.toString());
    }
  }

  @override
  Future<ApiResult<VideosDetails>> getAllChannelVideos(
      {required String channelId}) async {
    try {
      VideosIdsDetails videosIds =
          await _channelVideosAPIs.getAllChannelVideosIds(channelId: channelId);

      VideosDetails videosWithSubChannelDetails = await _videosDetailsRepository
          .getCompleteVideosDetailsOfThoseIds(videosIds);

      return ApiResult.success(videosWithSubChannelDetails);
    } catch (e) {
      return ApiResult.failure(e.toString());
    }
  }

  @override
  Future<ApiResult<VideosDetails>> getAllPopularChannelShortVideos(
      {required String channelId}) async {
    try {
      VideosIdsDetails shortVideosIds =
          await _channelVideosAPIs.getAllChannelShortVideosIds(
              channelId: channelId, orderVideos: "viewCount");

      VideosDetails videosWithSubChannelDetails = await _videosDetailsRepository
          .getCompleteVideosDetailsOfThoseIds(shortVideosIds);

      return ApiResult.success(videosWithSubChannelDetails);
    } catch (e) {
      return ApiResult.failure(e.toString());
    }
  }

  @override
  Future<ApiResult<VideosDetails>> getAllPopularChannelVideos(
      {required String channelId}) async {
    try {
      VideosIdsDetails videosIds =
          await _channelVideosAPIs.getAllChannelVideosIds(
              channelId: channelId, orderVideos: "viewCount");

      VideosDetails videosWithSubChannelDetails = await _videosDetailsRepository
          .getCompleteVideosDetailsOfThoseIds(videosIds);

      return ApiResult.success(videosWithSubChannelDetails);
    } catch (e) {
      return ApiResult.failure(e.toString());
    }
  }
}
