import 'package:youtube/core/functions/api_result.dart';

import 'package:youtube/core/utility/private_key.dart';
import 'package:youtube/data/data_sources/remote/api/single_video/single_video_apis.dart';
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
      return ApiResult.failure(e.toString());
    }
  }

  @override
  Future<void> rateVideo(
      {required String videoId, required String rating}) async {
    try {
      await _singleVideosAPIs.rateVideo(
          videoId: videoId, rating: rating, accessToken: accessToken);
    } catch (e) {
      return Future.error(e);
    }
  }
}
