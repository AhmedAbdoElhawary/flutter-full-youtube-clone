import 'package:youtube/core/functions/api_result.dart';
import 'package:youtube/core/use_case/use_case.dart';
import 'package:youtube/data/models/videos_details/videos_details.dart';
import 'package:youtube/domain/entities/parameters/channel_details_use_case_parameters.dart';
import 'package:youtube/domain/repositories/channel/channel_videos_repository.dart';

class ChannelShortPopularVideosUseCase
    implements
        FutureUseCase<ApiResult<VideosDetails>, ChannelDetailsUseCaseParameters> {
  final ChannelVideosDetailsRepository _videosDetailsRepository;

  ChannelShortPopularVideosUseCase(this._videosDetailsRepository);

  @override
  Future<ApiResult<VideosDetails>> call(
      {required ChannelDetailsUseCaseParameters params}) {
    return _videosDetailsRepository.getAllPopularChannelShortVideos(
        channelId: params.channelId);
  }
}
