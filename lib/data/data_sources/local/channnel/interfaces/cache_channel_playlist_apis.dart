import '../../../../../domain/entities/cache_items/cached_item.dart';
import '../../../../models/channel_details/playlists/playlists.dart';

part '../implements/cache_channel_playlist_apis_impl.dart';
abstract class CacheChannelPlaylistAPIs {
  PlayLists? getChannelPlayLists({required String channelId});
  void saveChannelPlayLists(
      {required String channelId, required PlayLists playLists});
  void clearChannelPlayLists({required String channelId});
}
