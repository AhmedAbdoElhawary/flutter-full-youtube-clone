import 'package:youtube/core/functions/api_result.dart';
import 'package:youtube/core/use_case/use_case.dart';
import 'package:youtube/domain/repositories/channel/channel_details_repository.dart';

class MySubscriptionsChannelsUseCase implements UseCase<ApiResult<void>, void> {
  final ChannelDetailsRepository _channelDetailsRepository;

  MySubscriptionsChannelsUseCase(this._channelDetailsRepository);

  @override
  Future<ApiResult<void>> call({required void params}) {
    return _channelDetailsRepository.getMySubscriptionsChannels();
  }
}
