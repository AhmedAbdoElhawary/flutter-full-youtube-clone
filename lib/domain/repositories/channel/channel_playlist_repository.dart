import 'package:youtube/core/helpers/handling_errors/api_result.dart';
import 'package:youtube/data/models/channel_details/playlists/playlists.dart';
import 'package:youtube/data/models/videos_details/videos_details.dart';

abstract class ChannelPlayListDetailsRepository {
  Future<void> clearChannelPlayLists({required String channelId});
  Future<void> clearMyPlayLists();

  Future<ApiResult<PlayLists>> getChannelPlayLists({required String channelId});
  Future<ApiResult<PlayLists>> getMyPlayLists();

  Future<ApiResult<List<VideosDetails>>> getChannelPlayListItem(
      {required String playlistId});
}
