import 'package:youtube/core/functions/api_result.dart';
import 'package:youtube/data/models/common/videos_ids/videos_ids.dart';
import 'package:youtube/data/models/videos_details/videos_details.dart';

abstract class VideosDetailsRepository {
  Future<ApiResult<VideosDetails>> getAllVideos();
  Future<ApiResult<VideosDetails>> getAllShortVideos();
  Future<ApiResult<VideosDetails>> getMostPopularVideos();
  Future<VideosDetails> getCompleteVideosDetailsOfThoseIds(VideosIdsDetails videosIdsDetails);
}
