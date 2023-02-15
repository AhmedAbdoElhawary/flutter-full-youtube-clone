import 'package:youtube/core/functions/api_result.dart';
import 'package:youtube/data/models/videos_details/videos_details.dart';

abstract class SearchDetailsRepository {
  Future<ApiResult<VideosDetails>> searchForThisSentence(
      {required String sentence});
  Future<ApiResult<VideosDetails>> getRelatedVideosToThisVideo(
      {required String relatedToVideoId});
}
