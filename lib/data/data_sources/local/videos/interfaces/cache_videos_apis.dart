import 'package:youtube/data/models/videos_details/videos_details.dart';

import '../../../../../domain/entities/cache_items/cached_item.dart';

part '../implements/cache_videos_apis_impl.dart';

abstract class CacheVideosAPIs {
  VideosDetails? getAllVideos();
  VideosDetails? getAllShortVideos();
  VideosDetails? getAllPopularVideos(String videoCategoryId);

  void saveAllVideos({required VideosDetails videosDetails});
  void saveAllShortVideos({required VideosDetails videosDetails});
  void saveAllPopularVideos(
      {required String videoCategoryId, required VideosDetails videosDetails});

  void clearAllVideos();
  void clearAllShortVideos();
  void clearAllPopularVideos(
      {required String videoCategoryId, bool clearAll = false});
}
