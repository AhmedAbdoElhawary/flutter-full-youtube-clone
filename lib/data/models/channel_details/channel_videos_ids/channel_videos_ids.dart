import 'package:json_annotation/json_annotation.dart';
import 'package:youtube/data/models/common/page_info/page_info.dart';

part 'channel_videos_ids.g.dart';
@JsonSerializable(includeIfNull: true, createToJson: false)
class ChannelVideosIds {
  String? nextPageToken;
  String? prevPageToken;
  PageInfo? pageInfo;
  List<ChannelVideosIdsItem?>? items;

  ChannelVideosIds(this.nextPageToken, this.pageInfo, this.items);


  factory ChannelVideosIds.fromJson(Map<String, dynamic> json) =>
      _$ChannelVideosIdsFromJson(json);
}

@JsonSerializable(includeIfNull: true, createToJson: false)
class ChannelVideoId {
  String? kind;
  String? videoId;

  ChannelVideoId(this.kind, this.videoId);


  factory ChannelVideoId.fromJson(Map<String, dynamic> json) =>
      _$ChannelVideoIdFromJson(json);
}

@JsonSerializable(includeIfNull: true, createToJson: false)
class ChannelVideosIdsItem {
  ChannelVideoId? id;

  ChannelVideosIdsItem(this.id);


  factory ChannelVideosIdsItem.fromJson(Map<String, dynamic> json) =>
      _$ChannelVideosIdsItemFromJson(json);
}
