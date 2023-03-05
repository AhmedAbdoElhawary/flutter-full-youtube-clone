import 'package:youtube/core/functions/handling_errors/api_result.dart';
import 'package:youtube/core/use_case/use_case.dart';
import 'package:youtube/data/models/channel_details/my_subscriptions/my_subscriptions_details.dart';
import 'package:youtube/domain/repositories/channel/channel_details_repository.dart';

class MySubscriptionsChannelsUseCase implements FutureUseCase<ApiResult<MySubscriptionsDetails>, void> {
  final ChannelDetailsRepository _channelDetailsRepository;

  MySubscriptionsChannelsUseCase(this._channelDetailsRepository);

  @override
  Future<ApiResult<MySubscriptionsDetails>> call({required void params}) {
    return _channelDetailsRepository.getMySubscriptionsChannels();
  }
}
