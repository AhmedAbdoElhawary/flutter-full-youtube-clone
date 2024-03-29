part of 'channel_videos_cubit.dart';

@freezed
class ChannelVideosState with _$ChannelVideosState {
  const factory ChannelVideosState.initial() = _Initial;

  const factory ChannelVideosState.channelLoading() = ChannelLoading;

  const factory ChannelVideosState.popularVideosLoaded(
      VideosDetails videoDetails) = PopularVideosLoaded;

  const factory ChannelVideosState.shortPopularVideosLoaded(
      VideosDetails videoDetails) = ShortPopularVideosLoaded;

  const factory ChannelVideosState.shortVideosLoaded(
      VideosDetails videoDetails) = ShortVideosLoaded;

  const factory ChannelVideosState.channelVideosLoaded(
      VideosDetails videoDetails) = ChannelVideosLoaded;

  const factory ChannelVideosState.videosOfThoseChannelsLoaded(
      List<VideoDetailsItem> videoDetails) = VideosOfThoseChannelsLoaded;

  const factory ChannelVideosState.channelError(
      NetworkExceptionModel networkExceptions) = ChannelError;
}
