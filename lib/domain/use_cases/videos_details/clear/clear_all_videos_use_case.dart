import 'package:youtube/core/use_case/use_case.dart';
import 'package:youtube/domain/repositories/videos_details_repository.dart';

class ClearAllVideosUseCase implements UseCase<void, void> {
  final VideosDetailsRepository _detailsRepository;

  ClearAllVideosUseCase(this._detailsRepository);

  @override
  void call({required void params}) => _detailsRepository.clearAllVideos();
}
