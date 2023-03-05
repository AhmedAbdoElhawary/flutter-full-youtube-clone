import 'package:youtube/core/functions/handling_errors/api_result.dart';
import 'package:youtube/core/functions/handling_errors/network_exceptions.dart';
import 'package:youtube/data/data_sources/remote/api/search/auto_complete_search/auto_complete_text_apis.dart';

import 'package:youtube/data/data_sources/remote/api/search/search_apis.dart';
import 'package:youtube/data/models/suggestion_texts/suggestion_texts.dart';
import 'package:youtube/data/models/searched_video_details/searched_video_details.dart';
import 'package:youtube/data/models/videos_details/videos_details.dart';
import 'package:youtube/domain/repositories/search_details_repository.dart';
import 'package:youtube/domain/repositories/videos_details_repository.dart';

class SearchDetailsRepoImpl implements SearchDetailsRepository {
  final SearchAPIs _searchAPIs;
  final SuggestionSearchTextAPIs _suggestionSearchTextAPIs;
  final VideosDetailsRepository _videosDetailsRepository;
  SearchDetailsRepoImpl(this._searchAPIs, this._videosDetailsRepository,
      this._suggestionSearchTextAPIs);

  @override
  Future<ApiResult<SuggestionTexts>> getSuggestionTexts(
      {required String text}) async {
    try {
      SuggestionTexts suggestionTexts =
          await _suggestionSearchTextAPIs.getSuggestionTexts(text);

      return ApiResult.success(suggestionTexts);
    } catch (e) {
      return ApiResult.failure(NetworkExceptions.getDioException(e));
    }
  }

  @override
  Future<ApiResult<VideosDetails>> getRelatedVideosToThisVideo(
      {required String relatedToVideoId}) async {
    try {
      SearchedVideosDetails videos = await _searchAPIs
          .getRelatedVideosIdsToThisVideo(relatedToVideoId: relatedToVideoId);

      VideosDetails videosWithSubChannelDetails = await _videosDetailsRepository
          .getCompleteVideosDetailsOfThoseIds(videos);

      return ApiResult.success(videosWithSubChannelDetails);
    } catch (e) {
      return ApiResult.failure(NetworkExceptions.getDioException(e));
    }
  }

  @override
  Future<ApiResult<VideosDetails>> searchForThisSentence(
      {required String sentence}) async {
    try {
      SearchedVideosDetails videos =
          await _searchAPIs.getIdsForThisSentence(sentence: sentence);

      VideosDetails videosWithSubChannelDetails = await _videosDetailsRepository
          .getCompleteVideosDetailsOfThoseIds(videos);

      return ApiResult.success(videosWithSubChannelDetails);
    } catch (e) {
      return ApiResult.failure(NetworkExceptions.getDioException(e));
    }
  }
}
