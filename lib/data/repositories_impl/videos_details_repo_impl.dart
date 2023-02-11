import 'package:youtube/core/functions/api_result.dart';
import 'package:youtube/core/functions/network_exceptions.dart';
import 'package:youtube/data/data_sources/remote/api/youtube_apis.dart';
import 'package:youtube/data/models/video_details/video_details.dart';
import 'package:youtube/domain/repositories/videos_details_repository.dart';

class VideoDetailsRepoImpl implements VideoDetailsRepository {
  final YoutubeAPIs _youtubeAPIs;
  VideoDetailsRepoImpl(this._youtubeAPIs);

  @override
  Future<ApiResult<VideoDetails>> getMostPopularVideos() async {
    try {
      VideoDetails videos = await _youtubeAPIs.getMostPopularVideos();
      return ApiResult.success(videos);
    } catch (e) {
      return ApiResult.failure(NetworkExceptions.getDioException(e));
    }
  }

  @override
  Future<ApiResult<VideoDetails>> getVideoDetails(
      {required String videoId}) async {
    try {
      VideoDetails videos =
          await _youtubeAPIs.getVideoDetails(videoId: videoId);
      return ApiResult.success(videos);
    } catch (e) {
      return ApiResult.failure(NetworkExceptions.getDioException(e));
    }
  }
}
