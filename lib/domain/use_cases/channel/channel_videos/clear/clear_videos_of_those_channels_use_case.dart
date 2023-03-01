import 'package:youtube/core/use_case/use_case.dart';
import 'package:youtube/domain/entities/parameters/clear_channel_videos_use_case_parameters.dart';
import 'package:youtube/domain/repositories/channel/channel_videos_repository.dart';

class ClearVideosOfThoseChannelsUseCase
    implements UseCase<void, ClearAllChannelVideosUseCasePara> {
  final ChannelVideosDetailsRepository _videosDetailsRepository;

  ClearVideosOfThoseChannelsUseCase(this._videosDetailsRepository);

  @override
  void call({required ClearAllChannelVideosUseCasePara params}) {
    return _videosDetailsRepository.clearVideosOfThoseChannels();
  }
}
