import 'package:youtube/core/functions/api_result.dart';
import 'package:youtube/core/use_case/use_case.dart';
import 'package:youtube/data/models/reply_details/reply_details.dart';
import 'package:youtube/domain/repositories/single_video_details_repository.dart';


class GetAllRepliesUseCase
    implements UseCase<ApiResult<ReplyDetails>, GetAllRepliesUseCaseParameters> {
  final SingleVideoDetailsRepository _videoDetailsRepository;

  GetAllRepliesUseCase(this._videoDetailsRepository);

  @override
  Future<ApiResult<ReplyDetails>> call(
      {required GetAllRepliesUseCaseParameters params}) {
    return _videoDetailsRepository.getRepliesForThisComment(
        commentId: params.commentId);
  }
}

class GetAllRepliesUseCaseParameters {
  final String commentId;
  GetAllRepliesUseCaseParameters({required this.commentId});
}
