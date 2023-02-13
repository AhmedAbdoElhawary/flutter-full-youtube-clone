import 'package:youtube/core/functions/api_result.dart';
import 'package:youtube/core/functions/network_exceptions.dart';
import 'package:youtube/data/data_sources/remote/api/channel/channel_apis.dart';
import 'package:youtube/data/models/channel_details/channel_details.dart';
import 'package:youtube/domain/repositories/channel_details_repository.dart';

class ChannelDetailsRepoImpl implements ChannelDetailsRepository {
  final ChannelAPIs _channelAPIs;
  ChannelDetailsRepoImpl(this._channelAPIs);

  @override
  Future<ApiResult<ChannelSubDetails>> getSubChannelDetails(
      {required String channelId}) async {
    try {
      ChannelSubDetails channelSubDetails =
      await _channelAPIs.getSubChannelInfo(channelId: channelId);
      return ApiResult.success(channelSubDetails);
    } catch (e) {
      return ApiResult.failure(NetworkExceptions.getDioException(e));
    }
  }
}
