import 'package:youtube/core/functions/api_result.dart';
import 'package:youtube/core/functions/network_exceptions.dart';
import 'package:youtube/data/data_sources/remote/api/search/search_apis.dart';
import 'package:youtube/data/models/common/videos_ids/videos_ids.dart';
import 'package:youtube/data/models/videos_details/videos_details.dart';
import 'package:youtube/domain/repositories/search_details_repository.dart';
import 'package:youtube/domain/repositories/videos_details_repository.dart';

class SearchDetailsRepoImpl implements SearchDetailsRepository {
  final SearchAPIs _searchAPIs;
  final VideosDetailsRepository _videosDetailsRepository;
  SearchDetailsRepoImpl(this._searchAPIs, this._videosDetailsRepository);

  @override
  Future<ApiResult<VideosDetails>> getRelatedVideosToThisVideo(
      {required String relatedToVideoId}) async {
    try {
      VideosIdsDetails videos = await _searchAPIs
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
      VideosIdsDetails videos =
          await _searchAPIs.getIdsForThisSentence(sentence: sentence);

      VideosDetails videosWithSubChannelDetails = await _videosDetailsRepository
          .getCompleteVideosDetailsOfThoseIds(videos);

      return ApiResult.success(videosWithSubChannelDetails);
    } catch (e) {
      return ApiResult.failure(NetworkExceptions.getDioException(e));
    }
  }
}
