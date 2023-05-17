import 'package:youtube/core/helpers/reformat/date_reformat.dart';
import 'package:youtube/data/models/channel_details/playlists/playlists.dart';
import 'package:youtube/data/models/common/thumbnail_details/max_thumbnail_details.dart';

extension PlaylistExtension on PlayListItem {
  String getPlaylistTitle() => snippet?.title ?? "";
  String getPlaylistPublishedTime() =>
      DateReformat.fullDigitFormat(snippet?.publishedAt);
  String getPlaylistDescription() => snippet?.description ?? "";
  MaxThumbnails? getPlaylistThumbnails() => snippet?.thumbnails;
  String? getPlaylistCoverImageUrl() => getPlaylistThumbnails()?.high?.url;
  String getPlayListStatus() => status?.privacyStatus ?? "";

  String getChannelName() => snippet?.channelTitle ?? "";
  int getPlaylistCount() => contentDetails?.itemCount ?? 0;
}
