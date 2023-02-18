part of 'play_list_cubit.dart';

@freezed
class PlayListState with _$PlayListState {
  const factory PlayListState.initial() = _Initial;

  const factory PlayListState.loading() = Loading;

  const factory PlayListState.playListItemsLoaded(
      PlayListVideos playListVideos) = PlayListItemsLoaded;

  const factory PlayListState.channelPlayListLoaded(PlayLists playLists) =
      ChannelPlayListLoaded;

  const factory PlayListState.error(NetworkExceptionModel networkExceptions) =
      Error;
}
