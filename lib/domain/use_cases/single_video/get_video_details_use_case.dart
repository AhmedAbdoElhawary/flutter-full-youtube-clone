import 'package:youtube/core/functions/api_result.dart';
import 'package:youtube/core/use_case/use_case.dart';
import 'package:youtube/data/models/videos_details/videos_details.dart';
import 'package:youtube/domain/entities/parameters/video_details_use_case_parameter.dart';
import 'package:youtube/domain/repositories/video_comment_details/single_video_details_repository.dart';

class VideoDetailsUseCase
    implements
        UseCase<ApiResult<VideosDetails>, VideoDetailsUseCaseParameters> {
  final SingleVideoDetailsRepository _videoDetailsRepository;

  VideoDetailsUseCase(this._videoDetailsRepository);

  @override
  Future<ApiResult<VideosDetails>> call(
      {required VideoDetailsUseCaseParameters params}) {
    return _videoDetailsRepository.getVideoDetails(videoId: params.videoId);
  }
}
