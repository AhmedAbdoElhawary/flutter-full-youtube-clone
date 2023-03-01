import 'package:youtube/core/use_case/use_case.dart';
import 'package:youtube/domain/repositories/channel/channel_details_repository.dart';

class ClearMySubscriptionsChannelsUseCase implements FutureUseCase<void, void> {
  final ChannelDetailsRepository _channelDetailsRepository;

  ClearMySubscriptionsChannelsUseCase(this._channelDetailsRepository);

  @override
  Future<void> call({required void params}) {
    return _channelDetailsRepository.clearMySubscriptionsChannels();
  }
}
