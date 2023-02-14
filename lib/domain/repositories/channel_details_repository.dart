import 'package:youtube/core/functions/api_result.dart';
import 'package:youtube/data/models/channel_details/channel_details.dart';
import 'package:youtube/data/models/videos_details/videos_details.dart';

abstract class ChannelDetailsRepository {
  Future<ApiResult<ChannelSubDetails>> getSubSingleChannelDetails(
      {required String channelId});
  Future<VideosDetails> getSubChannelsDetails(
      {required VideosDetails videosDetails});
}
