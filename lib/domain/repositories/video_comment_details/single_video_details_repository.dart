import 'package:youtube/core/helpers/handling_errors/api_result.dart';
import 'package:youtube/data/models/rating_details/rating_details.dart';
import 'package:youtube/data/models/videos_details/videos_details.dart';

abstract class SingleVideoDetailsRepository {
  Future<ApiResult<VideosDetails>> getVideoDetails({required String videoId});
  Future<ApiResult<void>> rateVideo({required String videoId, required String rating});
  Future<ApiResult<RatingDetails>> getVideoRating({required String videoId});
}
