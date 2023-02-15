import 'package:youtube/core/functions/api_result.dart';
import 'package:youtube/data/models/videos_details/videos_details.dart';

abstract class ChannelVideosDetailsRepository {
  Future<ApiResult<VideosDetails>> getAllChannelVideosIds({
    required String channelId,
  });

  Future<ApiResult<VideosDetails>> getAllChannelShortVideosIds({
    required String channelId,
  });
  Future<ApiResult<VideosDetails>> getAllPopularChannelVideosIds({
    required String channelId,
  });

  Future<ApiResult<VideosDetails>> getAllPopularChannelShortVideosIds({
    required String channelId,
  });
}
