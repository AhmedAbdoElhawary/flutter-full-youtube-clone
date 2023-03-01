import 'package:youtube/core/functions/api_result.dart';
import 'package:youtube/core/functions/network_exceptions.dart';
import 'package:youtube/data/data_sources/local/videos/interfaces/cache_videos_apis.dart';

import 'package:youtube/data/data_sources/remote/api/videos/videos_apis.dart';
import 'package:youtube/data/models/searched_video_details/searched_video_details.dart';
import 'package:youtube/data/models/videos_details/videos_details.dart';
import 'package:youtube/domain/repositories/channel/channel_details_repository.dart';
import 'package:youtube/domain/repositories/videos_details_repository.dart';

class VideosDetailsRepoImpl implements VideosDetailsRepository {
  final VideosAPIs _videosAPIs;
  final ChannelDetailsRepository _channelDetailsRepository;
  final CacheVideosAPIs _cacheVideosAPIs;
  VideosDetailsRepoImpl(
      this._videosAPIs, this._channelDetailsRepository, this._cacheVideosAPIs);

  @override
  Future<ApiResult<VideosDetails>> getAllVideos() async {
    try {
      VideosDetails? cachedAllVideos =  await _cacheVideosAPIs.getAllVideos();
      if (cachedAllVideos != null) return ApiResult.success(cachedAllVideos);

      SearchedVideosDetails videos = await _videosAPIs.getAllVideosIds();

      VideosDetails completeVideosDetails =
          await getCompleteVideosDetailsOfThoseIds(videos);

      await _cacheVideosAPIs.saveAllVideos(videosDetails: completeVideosDetails);

      return ApiResult.success(completeVideosDetails);
    } catch (e) {
      return ApiResult.failure(NetworkExceptions.getDioException(e));
    }
  }

  @override
  Future<ApiResult<VideosDetails>> getAllShortVideos() async {
    try {
      VideosDetails? cachedVideos =  await _cacheVideosAPIs.getAllShortVideos();
      if (cachedVideos != null) return ApiResult.success(cachedVideos);

      SearchedVideosDetails videos = await _videosAPIs.getAllShortVideosIds();

      VideosDetails completeVideosDetails =
          await getCompleteVideosDetailsOfThoseIds(videos);

      await _cacheVideosAPIs.saveAllShortVideos(videosDetails: completeVideosDetails);

      return ApiResult.success(completeVideosDetails);
    } catch (e) {
      return ApiResult.failure(NetworkExceptions.getDioException(e));
    }
  }

  @override
  Future<ApiResult<VideosDetails>> getMostPopularVideos(
      String videoCategoryId) async {
    try {
      VideosDetails? cachedVideos =
       await _cacheVideosAPIs.getAllPopularVideos(videoCategoryId);
      if (cachedVideos != null) return ApiResult.success(cachedVideos);

      VideosDetails videos = await _videosAPIs.getMostPopularVideos(
          videoCategoryId: videoCategoryId);

      VideosDetails completeVideosDetails = await _channelDetailsRepository
          .getSubChannelsDetails(videosDetails: videos);

       await _cacheVideosAPIs.saveAllPopularVideos(
          videoCategoryId: videoCategoryId,
          videosDetails: completeVideosDetails);

      return ApiResult.success(completeVideosDetails);
    } catch (e) {
      return ApiResult.failure(NetworkExceptions.getDioException(e));
    }
  }

  @override
  Future<VideosDetails> getCompleteVideosDetailsOfThoseIds(
      SearchedVideosDetails searchedVideos) async {
    try {
      String ids = "";
      for (final videoIdItem
          in searchedVideos.videoDetailsItem ?? <SearchedVideosItem>[]) {
        String id = videoIdItem.id?.videoId ?? "";
        if (id.isEmpty) continue;
        if (ids.isEmpty) {
          ids = id;
          continue;
        }
        ids += ",$id";
      }

      VideosDetails videos =
          await _videosAPIs.getVideosOfThoseIds(videosIds: ids);

      VideosDetails videosWithSubChannelDetails =
          await _channelDetailsRepository.getSubChannelsDetails(
              videosDetails: videos);

      return videosWithSubChannelDetails;
    } catch (e) {
      return Future.error(e);
    }
  }

  @override
  Future<void> clearAllVideos() async {
    await _cacheVideosAPIs.clearAllVideos();
  }

  @override
  Future<void> clearAllShortVideos() async {
    await _cacheVideosAPIs.clearAllShortVideos();
  }

  @override
  Future<void> clearAllPopularVideos(
      {required String videoCategoryId, required bool clearAll}) async {
    await _cacheVideosAPIs.clearAllPopularVideos(
        videoCategoryId: videoCategoryId, clearAll: clearAll);
  }
}
