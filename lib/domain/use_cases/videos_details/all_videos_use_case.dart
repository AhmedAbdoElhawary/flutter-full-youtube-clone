import 'package:youtube/core/functions/api_result.dart';
import 'package:youtube/core/use_case/use_case.dart';
import 'package:youtube/data/models/videos_details/videos_details.dart';
import 'package:youtube/domain/repositories/videos_details_repository.dart';

class AllVideosUseCase
    implements FutureUseCase<ApiResult<VideosDetails>, void> {
  final VideosDetailsRepository _detailsRepository;

  AllVideosUseCase(this._detailsRepository);

  @override
  Future<ApiResult<VideosDetails>> call({required void params}) {
    return _detailsRepository.getAllVideos();
  }
}
