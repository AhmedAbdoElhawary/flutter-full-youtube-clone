part of 'videos_details_cubit.dart';

@freezed
class VideosDetailsState with _$VideosDetailsState {
  const factory VideosDetailsState.initial() = _Initial;

  const factory VideosDetailsState.videoLoading() = VideoLoading;

  const factory VideosDetailsState.allVideosLoaded(
      VideosDetails allVideosLoaded) = AllVideosLoaded;

  const factory VideosDetailsState.allShortVideosLoaded(
      VideosDetails mostPopularVideos) = AllShortVideosLoaded;

  const factory VideosDetailsState.relatedVideosLoaded(VideosDetails videosDetails) =
  RelatedVideosLoaded;

  const factory VideosDetailsState.videoError(
      NetworkExceptionModel networkExceptions) = VideoError;
}
