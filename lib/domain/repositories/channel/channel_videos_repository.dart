import 'package:youtube/core/functions/api_result.dart';
import 'package:youtube/data/models/videos_details/videos_details.dart';

abstract class ChannelVideosDetailsRepository {
  Future<ApiResult<VideosDetails>> getAllChannelVideos({
    required String channelId,
  });

  Future<ApiResult<VideosDetails>> getAllChannelShortVideos({
    required String channelId,
  });
  Future<ApiResult<VideosDetails>> getAllPopularChannelVideos({
    required String channelId,
  });

  Future<ApiResult<VideosDetails>> getAllPopularChannelShortVideos({
    required String channelId,
  });
}
