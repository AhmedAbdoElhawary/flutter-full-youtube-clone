import 'package:youtube/core/functions/api_result.dart';
import 'package:youtube/core/use_case/use_case.dart';
import 'package:youtube/data/models/video_details/video_details.dart';
import 'package:youtube/domain/repositories/videos_details_repository.dart';

class VideoDetailsUseCase
    implements
        UseCase<ApiResult<VideosDetails>, VideoDetailsUseCaseParameters> {
  final VideoDetailsRepository _videoDetailsRepository;

  VideoDetailsUseCase(this._videoDetailsRepository);

  @override
  Future<ApiResult<VideosDetails>> call(
      {required VideoDetailsUseCaseParameters params}) {
    return _videoDetailsRepository.getVideoDetails(videoId: params.videoId);
  }
}

class VideoDetailsUseCaseParameters {
  final String videoId;
  VideoDetailsUseCaseParameters({required this.videoId});
}
