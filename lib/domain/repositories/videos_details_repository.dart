import 'package:youtube/core/functions/api_result.dart';
import 'package:youtube/data/models/video_details/video_details.dart';

abstract class VideoDetailsRepository {
  Future<ApiResult<VideoDetails>> getMostPopularVideos();
  Future<ApiResult<VideoDetails>> getVideoDetails({required String videoId});
}
