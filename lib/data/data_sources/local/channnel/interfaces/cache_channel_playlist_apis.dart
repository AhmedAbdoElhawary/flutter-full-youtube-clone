import '../../../../../domain/entities/cache_items/cached_item.dart';
import '../../../../models/channel_details/playlists/playlists.dart';

part '../implements/cache_channel_playlist_apis_impl.dart';

abstract class CacheChannelPlaylistAPIs {
  Future<PlayLists?> getChannelPlayLists({required String channelId});
  Future<PlayLists?> getMyPlayLists();
  Future<void> saveChannelPlayLists(
      {required String channelId, required PlayLists playLists});
  Future<void> saveMyPlayLists({required PlayLists playLists});
  Future<void> clearChannelPlayLists({required String channelId});
  Future<void> clearMyPlayLists();
}
