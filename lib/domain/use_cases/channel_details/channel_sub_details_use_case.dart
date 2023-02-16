import 'package:youtube/core/functions/api_result.dart';
import 'package:youtube/core/use_case/use_case.dart';
import 'package:youtube/data/models/channel_details/channel_details.dart';
import 'package:youtube/domain/entities/channel_details_use_case_parameters.dart';
import 'package:youtube/domain/repositories/channel/channel_details_repository.dart';

class ChannelSubDetailsUseCase
    implements
        UseCase<ApiResult<ChannelSubDetails>,
            ChannelDetailsUseCaseParameters> {
  final ChannelDetailsRepository _channelDetailsRepository;

  ChannelSubDetailsUseCase(this._channelDetailsRepository);

  @override
  Future<ApiResult<ChannelSubDetails>> call(
      {required ChannelDetailsUseCaseParameters params}) {
    return _channelDetailsRepository.getSubSingleChannelDetails(
        channelId: params.channelId);
  }
}