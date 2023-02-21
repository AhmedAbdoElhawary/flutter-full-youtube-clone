import 'package:youtube/core/functions/api_result.dart';
import 'package:youtube/data/models/searched_video_details/searched_video_details.dart';
import 'package:youtube/data/models/videos_details/videos_details.dart';

abstract class VideosDetailsRepository {
  Future<ApiResult<VideosDetails>> getAllVideos();
  Future<ApiResult<VideosDetails>> getAllShortVideos();
  Future<ApiResult<VideosDetails>> getMostPopularVideos(String videoCategoryId);
  Future<VideosDetails> getCompleteVideosDetailsOfThoseIds(
      SearchedVideosDetails searchedVideos);
}
