import 'package:youtube/core/functions/handling_errors/api_result.dart';
import 'package:youtube/core/use_case/use_case.dart';
import 'package:youtube/data/models/videos_details/videos_details.dart';
import 'package:youtube/domain/repositories/channel/channel_playlist_repository.dart';

class ChannelPlayListItemsUseCase
    implements
        FutureUseCase<ApiResult<List<VideosDetails>>,
            ChannelPlayListItemUseCaseParameter> {
  final ChannelPlayListDetailsRepository _listDetailsRepository;

  ChannelPlayListItemsUseCase(this._listDetailsRepository);

  @override
  Future<ApiResult<List<VideosDetails>>> call(
      {required ChannelPlayListItemUseCaseParameter params}) {
    return _listDetailsRepository.getChannelPlayListItem(
        playlistId: params.playlistId);
  }
}

class ChannelPlayListItemUseCaseParameter {
  String playlistId;

  ChannelPlayListItemUseCaseParameter({required this.playlistId});
}
