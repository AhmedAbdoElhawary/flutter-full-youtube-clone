import 'package:youtube/core/helpers/handling_errors/api_result.dart';
import 'package:youtube/core/use_case/use_case.dart';
import 'package:youtube/data/models/videos_details/videos_details.dart';
import 'package:youtube/domain/entities/parameters/channel_details_use_case_parameters.dart';
import 'package:youtube/domain/repositories/channel/channel_videos_repository.dart';

class ChannelVideosUseCase
    implements
        FutureUseCase<ApiResult<VideosDetails>, ChannelDetailsUseCaseParameters> {
  final ChannelVideosDetailsRepository _videosDetailsRepository;

  ChannelVideosUseCase(this._videosDetailsRepository);

  @override
  Future<ApiResult<VideosDetails>> call(
      {required ChannelDetailsUseCaseParameters params}) {
    return _videosDetailsRepository.getAllChannelVideos(
        channelId: params.channelId);
  }
}
