import 'package:youtube/core/helpers/handling_errors/api_result.dart';
import 'package:youtube/core/use_case/use_case.dart';
import 'package:youtube/data/models/channel_details/playlists/playlists.dart';
import 'package:youtube/domain/repositories/channel/channel_playlist_repository.dart';

class MyPlaylistsUseCase implements FutureUseCase<ApiResult<PlayLists>, void> {
  final ChannelPlayListDetailsRepository _listDetailsRepository;

  MyPlaylistsUseCase(this._listDetailsRepository);

  @override
  Future<ApiResult<PlayLists>> call({required void params}) {
    return _listDetailsRepository.getMyPlayLists();
  }
}
