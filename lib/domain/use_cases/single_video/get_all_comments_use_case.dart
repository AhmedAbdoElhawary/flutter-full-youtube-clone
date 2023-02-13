import 'package:youtube/core/functions/api_result.dart';
import 'package:youtube/core/use_case/use_case.dart';
import 'package:youtube/data/models/comment_details/comment_details.dart';
import 'package:youtube/domain/entities/video_details_use_case_parameter.dart';
import 'package:youtube/domain/repositories/single_video_details_repository.dart';

class GetAllCommentsUseCase
    implements
        UseCase<ApiResult<CommentDetails>, VideoDetailsUseCaseParameters> {
  final SingleVideoDetailsRepository _videoDetailsRepository;

  GetAllCommentsUseCase(this._videoDetailsRepository);

  @override
  Future<ApiResult<CommentDetails>> call(
      {required VideoDetailsUseCaseParameters params}) {
    return _videoDetailsRepository.getAllComments(videoId: params.videoId);
  }
}
