part of 'play_list_cubit.dart';

@freezed
class PlayListState with _$PlayListState {
  const factory PlayListState.initial() = _Initial;

  const factory PlayListState.playlistLoading() = PlaylistLoading;

  const factory PlayListState.playListItemsLoaded(
      List<VideosDetails> playListVideos) = PlayListItemsLoaded;

  const factory PlayListState.channelPlayListLoaded(PlayLists playLists) =
      ChannelPlayListLoaded;

  const factory PlayListState.myPlayListLoaded(PlayLists playLists) =
      MyPlayListLoaded;

  const factory PlayListState.playlistError(
      NetworkExceptionModel networkExceptions) = PlaylistError;
}
