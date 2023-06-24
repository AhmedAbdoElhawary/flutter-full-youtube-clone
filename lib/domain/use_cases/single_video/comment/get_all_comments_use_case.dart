import 'package:youtube/core/helpers/handling_errors/api_result.dart';
import 'package:youtube/core/use_case/use_case.dart';
import 'package:youtube/data/models/comment_details/comment_details.dart';
import 'package:youtube/domain/entities/parameters/video_details_use_case_parameter.dart';
import 'package:youtube/domain/repositories/video_comment_details/video_comment_details_repositroy.dart';

class GetAllCommentsUseCase
    implements
        FutureUseCase<ApiResult<CommentDetails>,
            VideoDetailsUseCaseParameters> {
  final VideoCommentDetailsRepository _commentDetailsRepository;

  GetAllCommentsUseCase(this._commentDetailsRepository);

  @override
  Future<ApiResult<CommentDetails>> call(
      {required VideoDetailsUseCaseParameters params}) {
    return _commentDetailsRepository.getAllComments(videoId: params.videoId);
  }
}
