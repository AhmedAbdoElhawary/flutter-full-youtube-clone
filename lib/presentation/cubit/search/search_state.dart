part of 'search_cubit.dart';

@freezed
class SearchState with _$SearchState {
  const factory SearchState.initial() = _Initial;

  const factory SearchState.loading() = Loading;

  const factory SearchState.searchForTheSentenceLoaded(
      VideosDetails videosDetails) = SearchForTheSentenceLoaded;

  const factory SearchState.relatedVideosLoaded(VideosDetails videosDetails) =
      RelatedVideosLoaded;

  const factory SearchState.error(String error) = Error;
}
