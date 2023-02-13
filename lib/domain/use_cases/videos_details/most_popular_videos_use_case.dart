import 'package:youtube/core/functions/api_result.dart';
import 'package:youtube/core/use_case/use_case.dart';
import 'package:youtube/data/models/video_details/video_details.dart';
import 'package:youtube/domain/repositories/videos_details_repository.dart';

class MostPopularVideosUseCase
    implements UseCase<ApiResult<VideosDetails>, void> {
  final VideosDetailsRepository _detailsRepository;

  MostPopularVideosUseCase(this._detailsRepository);

  @override
  Future<ApiResult<VideosDetails>> call({required void params}) {
    return _detailsRepository.getMostPopularVideos();
  }
}
