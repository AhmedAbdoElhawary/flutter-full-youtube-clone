import 'package:youtube/core/functions/handling_errors/api_result.dart';
import 'package:youtube/core/use_case/use_case.dart';
import 'package:youtube/domain/repositories/video_comment_details/single_video_details_repository.dart';

class RateVideoUseCase implements FutureUseCase<ApiResult<void>, RateVideoUseCaseParameter> {
  final SingleVideoDetailsRepository _videoDetailsRepository;

  RateVideoUseCase(this._videoDetailsRepository);

  @override
  Future<ApiResult<void>> call({required RateVideoUseCaseParameter params}) {
    return _videoDetailsRepository.rateVideo(
        videoId: params.videoId, rating: params.rating);
  }
}

/// [rating]	string
/// Specifies the rating to record.
///
/// Acceptable values are:
/// dislike – Records that the authenticated user disliked the video.
/// like – Records that the authenticated user liked the video.
/// none – Removes any rating that the authenticated user had previously set for the video.

class RateVideoUseCaseParameter {
  String videoId;
  String rating;

  RateVideoUseCaseParameter({required this.videoId, required this.rating});
}
