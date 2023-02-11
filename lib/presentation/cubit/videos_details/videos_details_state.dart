part of 'videos_details_cubit.dart';

@freezed
class VideosDetailsState with _$VideosDetailsState {
  const factory VideosDetailsState.initial() = _Initial;

  const factory VideosDetailsState.loading() = Loading;

  const factory VideosDetailsState.mostPopularVideosLoaded(
      VideoDetails mostPopularVideos) = MostPopularVideosLoaded;

  const factory VideosDetailsState.videoDetailsLoaded(
      VideoDetails videoDetails) = VideoDetailsLoaded;

  const factory VideosDetailsState.error(NetworkExceptions networkExceptions) =
      Error;
}
