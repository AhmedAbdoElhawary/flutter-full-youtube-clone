import 'package:youtube/core/functions/handling_errors/api_result.dart';
import 'package:youtube/core/use_case/use_case.dart';
import 'package:youtube/data/models/channel_details/channel_details.dart';
import 'package:youtube/domain/repositories/channel/channel_details_repository.dart';

class GetMyInfoUseCase implements FutureUseCase<ApiResult<ChannelSubDetails>, void> {
  final ChannelDetailsRepository _channelDetailsRepository;

  GetMyInfoUseCase(this._channelDetailsRepository);

  @override
  Future<ApiResult<ChannelSubDetails>> call({required void params}) {
    return _channelDetailsRepository.getMyChannelInfo();
  }
}
