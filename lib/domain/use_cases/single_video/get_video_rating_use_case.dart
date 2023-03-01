import 'package:youtube/core/functions/api_result.dart';
import 'package:youtube/core/use_case/use_case.dart';
import 'package:youtube/data/models/rating_details/rating_details.dart';
import 'package:youtube/domain/repositories/video_comment_details/single_video_details_repository.dart';

class GetVideoRatingUseCase
    implements
        FutureUseCase<ApiResult<RatingDetails>, GetVideoRatingUseCaseParameter> {
  final SingleVideoDetailsRepository _videoDetailsRepository;

  GetVideoRatingUseCase(this._videoDetailsRepository);

  @override
  Future<ApiResult<RatingDetails>> call(
      {required GetVideoRatingUseCaseParameter params}) {
    return _videoDetailsRepository.getVideoRating(videoId: params.videoId);
  }
}

class GetVideoRatingUseCaseParameter {
  String videoId;

  GetVideoRatingUseCaseParameter({required this.videoId});
}
