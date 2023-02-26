import 'package:youtube/core/functions/api_result.dart';
import 'package:youtube/core/use_case/use_case.dart';
import 'package:youtube/domain/entities/channel_details_use_case_parameters.dart';
import 'package:youtube/domain/repositories/channel/channel_details_repository.dart';

class DeleteSubscriptionUseCase implements UseCase<ApiResult<void>, DeleteSubscriptionUseCaseParameter> {
  final ChannelDetailsRepository _channelDetailsRepository;

  DeleteSubscriptionUseCase(this._channelDetailsRepository);

  @override
  Future<ApiResult<void>> call({required DeleteSubscriptionUseCaseParameter params}) {
    return _channelDetailsRepository.deleteSubscription(params.subscriptionId);
  }
}
class DeleteSubscriptionUseCaseParameter{
  String subscriptionId;

  DeleteSubscriptionUseCaseParameter({required this.subscriptionId});
}