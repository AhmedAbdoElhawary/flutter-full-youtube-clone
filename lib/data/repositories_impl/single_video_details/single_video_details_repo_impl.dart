import 'package:youtube/core/functions/api_result.dart';
import 'package:youtube/core/functions/network_exceptions.dart';

import 'package:youtube/core/utility/private_key.dart';
import 'package:youtube/data/data_sources/remote/api/single_video/single_video_apis.dart';
import 'package:youtube/data/models/rating_details/rating_details.dart';
import 'package:youtube/data/models/videos_details/videos_details.dart';
import 'package:youtube/domain/repositories/channel/channel_details_repository.dart';
import 'package:youtube/domain/repositories/video_comment_details/single_video_details_repository.dart';

class SingleVideosDetailsRepoImpl implements SingleVideoDetailsRepository {
  final SingleVideosAPIs _singleVideosAPIs;
  final ChannelDetailsRepository _channelDetailsRepository;

  SingleVideosDetailsRepoImpl(
      this._singleVideosAPIs, this._channelDetailsRepository);

  @override
  Future<ApiResult<VideosDetails>> getVideoDetails(
      {required String videoId}) async {
    try {
      VideosDetails videos =
          await _singleVideosAPIs.getVideoDetails(videoId: videoId);

      VideosDetails videosWithSubChannelDetails =
          await _channelDetailsRepository.getSubChannelsDetails(
              videosDetails: videos);

      return ApiResult.success(videosWithSubChannelDetails);
    } catch (e) {
      return ApiResult.failure(NetworkExceptions.getDioException(e));
    }
  }

  @override
  Future<ApiResult<void>> rateVideo(
      {required String videoId, required Rating rating}) async {
    try {
      await _singleVideosAPIs.rateVideo(
          videoId: videoId,
          rating: rating.toString(),
          accessToken: accessToken);

      return const ApiResult.success(null);
    } catch (e) {
      return ApiResult.failure(NetworkExceptions.getDioException(e));
    }
  }

  @override
  Future<ApiResult<RatingDetails>> getVideoRating(
      {required String videoId}) async {
    try {
      RatingDetails rating = await _singleVideosAPIs.getVideoRating(
          videoId: videoId, accessToken: accessToken);

      return ApiResult.success(rating);
    } catch (e) {
      return ApiResult.failure(NetworkExceptions.getDioException(e));
    }
  }
}
