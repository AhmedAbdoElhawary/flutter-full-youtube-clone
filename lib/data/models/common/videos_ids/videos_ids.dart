import 'package:json_annotation/json_annotation.dart';
import 'package:youtube/data/models/common/page_info/page_info.dart';

part 'videos_ids.g.dart';

@JsonSerializable(includeIfNull: true, createToJson: false)
class VideosIdsDetails {
  String? nextPageToken;
  String? prevPageToken;
  PageInfo? pageInfo;
  List<VideoIdItem?>? items;

  VideosIdsDetails(
      this.nextPageToken, this.prevPageToken, this.pageInfo, this.items);

  factory VideosIdsDetails.fromJson(Map<String, dynamic> json) =>
      _$VideosIdsDetailsFromJson(json);
}

@JsonSerializable(includeIfNull: true, createToJson: false)
class VideoIdItemDetails {
  String? kind;
  String? videoId;

  VideoIdItemDetails(this.kind, this.videoId);

  factory VideoIdItemDetails.fromJson(Map<String, dynamic> json) =>
      _$VideoIdItemDetailsFromJson(json);
}

@JsonSerializable(includeIfNull: true, createToJson: false)
class VideoIdItem {
  VideoIdItemDetails? id;

  VideoIdItem(this.id);

  factory VideoIdItem.fromJson(Map<String, dynamic> json) =>
      _$VideoIdItemFromJson(json);
}
