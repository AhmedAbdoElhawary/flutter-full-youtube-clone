import 'package:youtube/core/use_case/use_case.dart';
import 'package:youtube/domain/entities/parameters/clear_channel_videos_use_case_parameters.dart';
import 'package:youtube/domain/repositories/channel/channel_videos_repository.dart';

class ClearAllPopularChannelShortVideosUseCase
    implements FutureUseCase<void, ClearAllChannelVideosUseCasePara> {
  final ChannelVideosDetailsRepository _videosDetailsRepository;

  ClearAllPopularChannelShortVideosUseCase(this._videosDetailsRepository);

  @override
  Future<void> call({required ClearAllChannelVideosUseCasePara params}) {
    return _videosDetailsRepository.clearAllPopularChannelShortVideos(
        channelId: params.channelId, clearAll: params.clearAll);
  }
}
