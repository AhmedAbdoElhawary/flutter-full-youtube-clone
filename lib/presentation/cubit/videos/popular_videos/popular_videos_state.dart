part of 'popular_videos_cubit.dart';

@freezed
class PopularVideosState with _$PopularVideosState {
  const factory PopularVideosState.initial() = _Initial;

  const factory PopularVideosState.loading() = Loading;

  const factory PopularVideosState.mostPopularMusicVideosLoaded(
      VideosDetails mostPopularVideos) = MostPopularMusicVideosLoaded;

  const factory PopularVideosState.mostPopularGamingVideosLoaded(
      VideosDetails mostPopularVideos) = MostPopularGamingVideosLoaded;

  const factory PopularVideosState.mostPopularMoviesVideosLoaded(
      VideosDetails mostPopularVideos) = MostPopularMoviesVideosLoaded;

  const factory PopularVideosState.mostPopularVideosLoaded(
      VideosDetails mostPopularVideos) = MostPopularVideosLoaded;

  const factory PopularVideosState.error(String error) = Error;
}
