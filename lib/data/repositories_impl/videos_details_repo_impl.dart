import 'package:youtube/core/functions/api_result.dart';
import 'package:youtube/core/functions/network_exceptions.dart';
import 'package:youtube/data/data_sources/remote/api/videos/videos_apis.dart';
import 'package:youtube/data/models/video_details/video_details.dart';
import 'package:youtube/domain/repositories/videos_details_repository.dart';

class VideosDetailsRepoImpl implements VideosDetailsRepository {
  final VideosAPIs _youtubeAPIs;
  VideosDetailsRepoImpl(this._youtubeAPIs);

  @override
  Future<ApiResult<VideosDetails>> getMostPopularVideos() async {
    try {
      VideosDetails videos = await _youtubeAPIs.getMostPopularVideos();
      return ApiResult.success(videos);
    } catch (e) {
      return ApiResult.failure(NetworkExceptions.getDioException(e));
    }
  }
}
