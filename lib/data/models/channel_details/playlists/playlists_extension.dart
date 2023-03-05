import 'package:youtube/core/functions/reformat/date_reformat.dart';
import 'package:youtube/data/models/channel_details/playlists/playlists.dart';
import 'package:youtube/data/models/common/thumbnail_details/max_thumbnail_details.dart';

extension PlaylistsExtension on PlayListsItem {
  String getPlaylistTitle() => snippet?.title ?? "";
  String getPlaylistPublishedTime() =>
      DateReformat.fullDigitFormat(snippet?.publishedAt);
  String getPlaylistDescription() => snippet?.description ?? "";
  MaxThumbnails? getPlaylistThumbnails() => snippet?.thumbnails;

  String getChannelName() => snippet?.channelTitle ?? "";
  int getPlaylistCount() => contentDetails?.itemCount ?? 0;
}
