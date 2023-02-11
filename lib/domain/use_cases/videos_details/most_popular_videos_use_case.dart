import 'package:youtube/core/functions/api_result.dart';
import 'package:youtube/core/use_case/use_case.dart';
import 'package:youtube/data/models/video_details/video_details.dart';
import 'package:youtube/domain/repositories/videos_details_repository.dart';

class MostPopularVideosUseCase
    implements UseCase<ApiResult<VideoDetails>, void> {
  final VideoDetailsRepository _videosUseCase;

  MostPopularVideosUseCase(this._videosUseCase);

  @override
  Future<ApiResult<VideoDetails>> call({required void params}) {
    return _videosUseCase.getMostPopularVideos();
  }
}
