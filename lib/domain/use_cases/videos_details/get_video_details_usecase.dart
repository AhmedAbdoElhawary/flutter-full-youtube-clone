import 'package:youtube/core/functions/api_result.dart';
import 'package:youtube/core/use_case/use_case.dart';
import 'package:youtube/data/models/video_details/video_details.dart';
import 'package:youtube/domain/repositories/videos_details_repository.dart';

class VideoDetailsUseCase
    implements
        UseCase<ApiResult<VideoDetails>, VideoDetailsUseCaseParameters> {
  final VideoDetailsRepository _videosUseCase;

  VideoDetailsUseCase(this._videosUseCase);

  @override
  Future<ApiResult<VideoDetails>> call(
      {required VideoDetailsUseCaseParameters params}) {
    return _videosUseCase.getVideoDetails(videoId: params.videoId);
  }
}

class VideoDetailsUseCaseParameters {
  final String videoId;
  VideoDetailsUseCaseParameters({required this.videoId});
}
