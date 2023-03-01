import 'package:youtube/core/functions/api_result.dart';
import 'package:youtube/core/use_case/use_case.dart';
import 'package:youtube/data/models/channel_details/playlists/playlist_videos.dart';
import 'package:youtube/domain/repositories/channel/channel_playlist_repository.dart';

class ChannelPlayListItemsUseCase
    implements
        FutureUseCase<ApiResult<PlayListVideos>,
            ChannelPlayListItemUseCaseParameter> {
  final ChannelPlayListDetailsRepository _listDetailsRepository;

  ChannelPlayListItemsUseCase(this._listDetailsRepository);

  @override
  Future<ApiResult<PlayListVideos>> call(
      {required ChannelPlayListItemUseCaseParameter params}) {
    return _listDetailsRepository.getChannelPlayListItem(
        playlistId: params.playlistId);
  }
}

class ChannelPlayListItemUseCaseParameter {
  String playlistId;

  ChannelPlayListItemUseCaseParameter({required this.playlistId});
}
