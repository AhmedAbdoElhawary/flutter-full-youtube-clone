import 'package:youtube/core/use_case/use_case.dart';
import 'package:youtube/domain/repositories/videos_details_repository.dart';

class ClearAllPopularVideosUseCase
    implements UseCase<void, ClearAllPopularVideosUseCasePara> {
  final VideosDetailsRepository _detailsRepository;

  ClearAllPopularVideosUseCase(this._detailsRepository);

  @override
  void call({required ClearAllPopularVideosUseCasePara params}) {
    _detailsRepository.clearAllPopularVideos(
        videoCategoryId: params.videoCategoryId, clearAll: params.clearAll);
  }
}

class ClearAllPopularVideosUseCasePara {
  String videoCategoryId;
  bool clearAll;

  ClearAllPopularVideosUseCasePara(
      {required this.videoCategoryId, required this.clearAll});
}
