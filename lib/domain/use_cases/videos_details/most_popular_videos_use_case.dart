import 'package:youtube/core/helpers/handling_errors/api_result.dart';
import 'package:youtube/core/use_case/use_case.dart';
import 'package:youtube/data/models/videos_details/videos_details.dart';
import 'package:youtube/domain/repositories/videos_details_repository.dart';

class MostPopularVideosUseCase
    implements FutureUseCase<ApiResult<VideosDetails>, MostPopularVideosUseCasePar> {
  final VideosDetailsRepository _detailsRepository;

  MostPopularVideosUseCase(this._detailsRepository);

  @override
  Future<ApiResult<VideosDetails>> call(
      {required MostPopularVideosUseCasePar params}) {
    return _detailsRepository
        .getMostPopularVideos(params.popularVideoCategoryId);
  }
}

class MostPopularVideosUseCasePar {
  String popularVideoCategoryId;

  MostPopularVideosUseCasePar({this.popularVideoCategoryId = "0"});
}
