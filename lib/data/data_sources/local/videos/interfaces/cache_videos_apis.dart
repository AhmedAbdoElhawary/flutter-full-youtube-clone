import 'package:youtube/data/models/videos_details/videos_details.dart';

import '../../../../../domain/entities/cache_items/cached_item.dart';

part '../implements/cache_videos_apis_impl.dart';

abstract class CacheVideosAPIs {
  Future<VideosDetails?> getAllVideos();
  Future<VideosDetails?> getAllShortVideos();
  Future<VideosDetails?> getAllPopularVideos(String videoCategoryId);

  Future<void> saveAllVideos({required VideosDetails videosDetails});
  Future<void> saveAllShortVideos({required VideosDetails videosDetails});
  Future<void> saveAllPopularVideos(
      {required String videoCategoryId, required VideosDetails videosDetails});

  Future<void> clearAllVideos();
  Future<void> clearAllShortVideos();
  Future<void> clearAllPopularVideos(
      {required String videoCategoryId, bool clearAll = false});
}
