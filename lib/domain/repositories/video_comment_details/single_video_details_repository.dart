import 'package:youtube/core/functions/api_result.dart';
import 'package:youtube/data/models/videos_details/videos_details.dart';

abstract class SingleVideoDetailsRepository {
  Future<ApiResult<VideosDetails>> getVideoDetails({required String videoId});
  Future<void> rateVideo({required String videoId,required String rating});
}
