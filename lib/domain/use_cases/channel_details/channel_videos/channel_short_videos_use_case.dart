import 'package:youtube/core/functions/api_result.dart';
import 'package:youtube/core/use_case/use_case.dart';
import 'package:youtube/data/models/videos_details/videos_details.dart';
import 'package:youtube/domain/entities/channel_details_use_case_parameters.dart';
import 'package:youtube/domain/repositories/channel/channel_videos_repository.dart';

class ChannelShortVideosUseCase
    implements
        UseCase<ApiResult<VideosDetails>, ChannelDetailsUseCaseParameters> {
  final ChannelVideosDetailsRepository _videosDetailsRepository;

  ChannelShortVideosUseCase(this._videosDetailsRepository);

  @override
  Future<ApiResult<VideosDetails>> call(
      {required ChannelDetailsUseCaseParameters params}) {
    return _videosDetailsRepository.getAllChannelShortVideos(
        channelId: params.channelId);
  }
}
