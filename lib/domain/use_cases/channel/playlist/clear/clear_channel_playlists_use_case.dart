import 'package:youtube/core/use_case/use_case.dart';
import 'package:youtube/domain/entities/parameters/channel_details_use_case_parameters.dart';
import 'package:youtube/domain/repositories/channel/channel_playlist_repository.dart';

class CleaChannelPlaylistsUseCase
    implements FutureUseCase<void, ChannelDetailsUseCaseParameters> {
  final ChannelPlayListDetailsRepository _playListDetailsRepository;

  CleaChannelPlaylistsUseCase(this._playListDetailsRepository);

  @override
  Future<void> call({required ChannelDetailsUseCaseParameters params}) {
    return _playListDetailsRepository.clearChannelPlayLists(
        channelId: params.channelId);
  }
}
