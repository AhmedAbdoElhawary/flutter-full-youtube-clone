import 'package:youtube/core/functions/api_result.dart';
import 'package:youtube/core/use_case/use_case.dart';
import 'package:youtube/data/models/channel_details/my_subscriptions/my_subscriptions_details.dart';
import 'package:youtube/data/models/videos_details/videos_details.dart';
import 'package:youtube/domain/repositories/channel/channel_videos_repository.dart';

class GetVideosOfThoseChannelsUseCase
    implements
        FutureUseCase<ApiResult<List<VideosDetails>>, GetVideosOfThoseChannelsUseCaseParameter> {
  final ChannelVideosDetailsRepository _channelDetailsRepository;

  GetVideosOfThoseChannelsUseCase(this._channelDetailsRepository);

  @override
  Future<ApiResult<List<VideosDetails>>> call(
      {required GetVideosOfThoseChannelsUseCaseParameter params}) {
    return _channelDetailsRepository.getVideosOfThoseChannels(
        mySubscriptionsDetails: params.mySubscriptionsDetails);
  }
}

class GetVideosOfThoseChannelsUseCaseParameter {
  MySubscriptionsDetails mySubscriptionsDetails;

  GetVideosOfThoseChannelsUseCaseParameter(
      {required this.mySubscriptionsDetails});
}
