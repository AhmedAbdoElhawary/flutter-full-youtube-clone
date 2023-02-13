import 'package:youtube/core/functions/api_result.dart';
import 'package:youtube/core/use_case/use_case.dart';
import 'package:youtube/data/models/comment_details/comment_details.dart';
import 'package:youtube/domain/repositories/single_video_details_repository.dart';

class GetAllRepliesUseCase
    implements UseCase<ApiResult<CommentDetails>, AllRepliesUseCaseParameters> {
  final SingleVideoDetailsRepository _videoDetailsRepository;

  GetAllRepliesUseCase(this._videoDetailsRepository);

  @override
  Future<ApiResult<CommentDetails>> call(
      {required AllRepliesUseCaseParameters params}) {
    return _videoDetailsRepository.getRepliesForThisComment(
        commentId: params.commentId);
  }
}

class AllRepliesUseCaseParameters {
  final String commentId;
  AllRepliesUseCaseParameters({required this.commentId});
}
