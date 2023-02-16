import 'package:youtube/core/functions/api_result.dart';
import 'package:youtube/core/use_case/use_case.dart';
import 'package:youtube/data/models/videos_details/videos_details.dart';
import 'package:youtube/domain/repositories/search_details_repository.dart';

class RelatedVideosToThisVideoUseCase
    implements
        UseCase<ApiResult<VideosDetails>, RelatedVideosToThisVideoUseCasePara> {
  final SearchDetailsRepository _searchDetailsRepository;

  RelatedVideosToThisVideoUseCase(this._searchDetailsRepository);

  @override
  Future<ApiResult<VideosDetails>> call(
      {required RelatedVideosToThisVideoUseCasePara params}) {
    return _searchDetailsRepository.getRelatedVideosToThisVideo(
        relatedToVideoId: params.relatedToVideoId);
  }
}

class RelatedVideosToThisVideoUseCasePara {
  String relatedToVideoId;
  RelatedVideosToThisVideoUseCasePara({required this.relatedToVideoId});
}
