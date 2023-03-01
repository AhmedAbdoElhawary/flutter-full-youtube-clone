import 'package:youtube/core/functions/api_result.dart';
import 'package:youtube/core/use_case/use_case.dart';
import 'package:youtube/data/models/channel_details/playlists/playlists.dart';
import 'package:youtube/domain/entities/parameters/channel_details_use_case_parameters.dart';
import 'package:youtube/domain/repositories/channel/channel_playlist_repository.dart';

class ChannelPlayListUseCase
    implements FutureUseCase<ApiResult<PlayLists>, ChannelDetailsUseCaseParameters> {
  final ChannelPlayListDetailsRepository _listDetailsRepository;

  ChannelPlayListUseCase(this._listDetailsRepository);

  @override
  Future<ApiResult<PlayLists>> call(
      {required ChannelDetailsUseCaseParameters params}) {
    return _listDetailsRepository.getChannelPlayLists(
        channelId: params.channelId);
  }
}
