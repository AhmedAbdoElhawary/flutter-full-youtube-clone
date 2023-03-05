import 'package:youtube/core/functions/handling_errors/api_result.dart';
import 'package:youtube/data/models/suggestion_texts/suggestion_texts.dart';
import 'package:youtube/data/models/videos_details/videos_details.dart';

abstract class SearchDetailsRepository {
  Future<ApiResult<SuggestionTexts>> getSuggestionTexts({required String text});
  Future<ApiResult<VideosDetails>> searchForThisSentence(
      {required String sentence});
  Future<ApiResult<VideosDetails>> getRelatedVideosToThisVideo(
      {required String relatedToVideoId});
}
