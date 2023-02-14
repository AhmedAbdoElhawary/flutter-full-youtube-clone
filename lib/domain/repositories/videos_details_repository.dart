import 'package:youtube/core/functions/api_result.dart';
import 'package:youtube/data/models/videos_details/videos_details.dart';

abstract class VideosDetailsRepository {
  Future<ApiResult<VideosDetails>> getMostPopularVideos();
}
