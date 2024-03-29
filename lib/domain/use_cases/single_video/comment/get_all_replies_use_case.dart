import 'package:youtube/core/helpers/handling_errors/api_result.dart';
import 'package:youtube/core/use_case/use_case.dart';
import 'package:youtube/data/models/reply_details/reply_details.dart';
import 'package:youtube/domain/repositories/video_comment_details/video_comment_details_repositroy.dart';

class GetAllRepliesUseCase
    implements
        FutureUseCase<ApiResult<ReplyDetails>, GetAllRepliesUseCaseParameters> {
  final VideoCommentDetailsRepository _commentDetailsRepository;

  GetAllRepliesUseCase(this._commentDetailsRepository);

  @override
  Future<ApiResult<ReplyDetails>> call(
      {required GetAllRepliesUseCaseParameters params}) {
    return _commentDetailsRepository.getRepliesForThisComment(
        commentId: params.commentId);
  }
}

class GetAllRepliesUseCaseParameters {
  final String commentId;
  GetAllRepliesUseCaseParameters({required this.commentId});
}
