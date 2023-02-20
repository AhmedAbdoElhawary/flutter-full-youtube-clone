import 'package:dio/dio.dart';
import 'package:youtube/core/functions/api_result.dart';
import 'package:youtube/core/functions/network_exceptions.dart';
import 'package:youtube/core/utility/constants.dart';
import 'package:youtube/core/utility/private_key.dart';
import 'package:youtube/data/data_sources/remote/api/search/auto_complete_search/auto_complete_text_apis.dart';

import 'package:youtube/data/data_sources/remote/api/search/search_apis.dart';
import 'package:youtube/data/models/suggestion_texts/suggestion_texts.dart';
import 'package:youtube/data/models/videos_details/searched_video_details/searched_video_details.dart';
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
      //
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
          await getIdsForThisSentence(sentence: sentence);
      print("1----------------1111111111> $videos");
      VideosDetails videosWithSubChannelDetails = await _videosDetailsRepository
          .getCompleteVideosDetailsOfThoseIds(videos);
      // print("1----------------22222222222> ${videosWithSubChannelDetails.videoDetailsItem?[0].id}");

      return ApiResult.success(videosWithSubChannelDetails);
    } catch (e) {
      return ApiResult.failure(NetworkExceptions.getDioException(e));
    }
  }

  Future<SearchedVideosDetails> getIdsForThisSentence({
    apiKey = apiKey,
    required sentence,
  }) async {
    Dio dio = Dio();
    const extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'key': apiKey,
      r'q': sentence,
    };
    final headers = <String, dynamic>{};
    final data = <String, dynamic>{};
    final result = await dio.fetch<Map<String, dynamic>>(
        _setStreamType<SearchedVideosDetails>(Options(
      method: 'GET',
      headers: headers,
      extra: extra,
    )
            .compose(
              dio.options,
              'search?part=snippet',
              queryParameters: queryParameters,
              data: data,
            )
            .copyWith(baseUrl: youtubeBaseUrl)));
    final value = SearchedVideosDetails.fromJson(result.data!);
    print("wwwwwwwwwwwwwwwwwwwwwww> ${value.videoDetailsItem?[0].id?.videoId},11111 ${result.data!}");
    return value;
  }

  RequestOptions _setStreamType<T>(RequestOptions requestOptions) {
    if (T != dynamic &&
        !(requestOptions.responseType == ResponseType.bytes ||
            requestOptions.responseType == ResponseType.stream)) {
      if (T == String) {
        requestOptions.responseType = ResponseType.plain;
      } else {
        requestOptions.responseType = ResponseType.json;
      }
    }
    return requestOptions;
  }
}
