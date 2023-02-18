part of 'videos_details_cubit.dart';

@freezed
class VideosDetailsState with _$VideosDetailsState {
  const factory VideosDetailsState.initial() = _Initial;

  const factory VideosDetailsState.loading() = Loading;

  const factory VideosDetailsState.allVideosLoaded(
      VideosDetails mostPopularVideos) = AllVideosLoaded;

  const factory VideosDetailsState.allShortVideosLoaded(
      VideosDetails mostPopularVideos) = AllShortVideosLoaded;

  const factory VideosDetailsState.mostPopularVideosLoaded(
      VideosDetails mostPopularVideos) = MostPopularVideosLoaded;

  const factory VideosDetailsState.error(
      NetworkExceptionModel networkExceptions) = Error;
}
