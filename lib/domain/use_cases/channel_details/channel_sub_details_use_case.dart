import 'package:youtube/core/functions/api_result.dart';
import 'package:youtube/core/use_case/use_case.dart';
import 'package:youtube/data/models/channel_details/channel_details.dart';
import 'package:youtube/domain/repositories/channel_details_repository.dart';

class ChannelSubDetailsUseCase
    implements
        UseCase<ApiResult<ChannelSubDetails>,
            ChannelSubDetailsUseCaseParameters> {
  final ChannelDetailsRepository _channelDetailsRepository;

  ChannelSubDetailsUseCase(this._channelDetailsRepository);

  @override
  Future<ApiResult<ChannelSubDetails>> call(
      {required ChannelSubDetailsUseCaseParameters params}) {
    return _channelDetailsRepository.getSubChannelDetails(
        channelId: params.channelId);
  }
}

class ChannelSubDetailsUseCaseParameters {
  final String channelId;
  ChannelSubDetailsUseCaseParameters({required this.channelId});
}
