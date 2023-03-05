import 'package:json_annotation/json_annotation.dart';
import 'package:youtube/data/models/common/page_info/page_info.dart';

part 'playlist_videos.g.dart';

@JsonSerializable(includeIfNull: true, createToJson: false)
class PlayListVideos {
  List<PlayListVideosItem?>? items;
  PageInfo? pageInfo;
  String? nextPageToken;
  String? prevPageToken;
  PlayListVideos(
      {this.items, this.pageInfo, this.nextPageToken, this.prevPageToken});

  factory PlayListVideos.fromJson(Map<String, dynamic> json) =>
      _$PlayListVideosFromJson(json);
}

class PlayListVideosItem {
  String? videoId;

  PlayListVideosItem(this.videoId);

  factory PlayListVideosItem.fromJson(Map<String, dynamic> json) {
    return PlayListVideosItem(json["contentDetails"]["videoId"]);
  }
}
