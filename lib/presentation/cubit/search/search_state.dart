part of 'search_cubit.dart';

@freezed
class SearchState with _$SearchState {
  const factory SearchState.initial() = _Initial;

  const factory SearchState.loading() = Loading;

  const factory SearchState.searchForTheSentenceLoaded(
      VideosDetails videosDetails) = SearchForTheSentenceLoaded;

  const factory SearchState.suggestionTextsLoaded(
      SuggestionTexts suggestionTexts) = SuggestionTextsLoaded;

  const factory SearchState.relatedVideosLoaded(VideosDetails videosDetails) =
      RelatedVideosLoaded;

  const factory SearchState.error(NetworkExceptionModel networkExceptions) =
      Error;
}
