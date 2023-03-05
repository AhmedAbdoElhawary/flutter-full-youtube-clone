import 'package:youtube/core/functions/handling_errors/api_result.dart';
import 'package:youtube/core/use_case/use_case.dart';
import 'package:youtube/domain/entities/parameters/channel_details_use_case_parameters.dart';
import 'package:youtube/domain/repositories/channel/channel_details_repository.dart';

class SubscribeToChannelUseCase
    implements FutureUseCase<ApiResult<void>, ChannelDetailsUseCaseParameters> {
  final ChannelDetailsRepository _channelDetailsRepository;

  SubscribeToChannelUseCase(this._channelDetailsRepository);

  @override
  Future<ApiResult<void>> call(
      {required ChannelDetailsUseCaseParameters params}) {
    return _channelDetailsRepository.subscribeToChannel(
        channelId: params.channelId);
  }
}
