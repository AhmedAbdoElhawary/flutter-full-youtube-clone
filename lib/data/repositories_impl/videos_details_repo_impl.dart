import 'package:youtube/core/functions/api_result.dart';
import 'package:youtube/core/functions/network_exceptions.dart';
import 'package:youtube/data/data_sources/remote/api/videos/videos_apis.dart';
import 'package:youtube/data/models/video_details/video_details.dart';
import 'package:youtube/domain/repositories/channel_details_repository.dart';
import 'package:youtube/domain/repositories/videos_details_repository.dart';

class VideosDetailsRepoImpl implements VideosDetailsRepository {
  final VideosAPIs _youtubeAPIs;
  final ChannelDetailsRepository _channelDetailsRepository;
  VideosDetailsRepoImpl(this._youtubeAPIs, this._channelDetailsRepository);

  @override
  Future<ApiResult<VideosDetails>> getMostPopularVideos() async {
    try {
      VideosDetails videos = await _youtubeAPIs.getMostPopularVideos();

      VideosDetails videosWithSubChannelDetails =
          await _channelDetailsRepository.getSubChannelsDetails(
              videosDetails: videos);

      return ApiResult.success(videosWithSubChannelDetails);
    } catch (e) {
      return ApiResult.failure(NetworkExceptions.getDioException(e));
    }
  }
}