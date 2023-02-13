import 'package:youtube/core/functions/api_result.dart';
import 'package:youtube/data/models/channel_details/channel_details.dart';

abstract class ChannelDetailsRepository {
  Future<ApiResult<ChannelSubDetails>> getSubChannelDetails(
      {required String channelId});
}
