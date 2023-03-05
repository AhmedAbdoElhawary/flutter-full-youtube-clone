import 'package:json_annotation/json_annotation.dart';
import 'package:youtube/data/models/common/page_info/page_info.dart';
import 'package:youtube/data/models/common/thumbnail_details/max_thumbnail_details.dart';

part 'playlist_videos.g.dart';

@JsonSerializable(includeIfNull: true, createToJson: false)
class PlayListVideos {
  List<PlayListVideos?>? items;
  PageInfo? pageInfo;

  PlayListVideos({this.items, this.pageInfo});

  factory PlayListVideos.fromJson(Map<String, dynamic> json) =>
      _$PlayListVideosFromJson(json);
}

@JsonSerializable(includeIfNull: true, createToJson: false)
class PlayListVideosContentDetails {
  String? videoId;
  DateTime? videoPublishedAt;

  PlayListVideosContentDetails({this.videoId, this.videoPublishedAt});

  factory PlayListVideosContentDetails.fromJson(Map<String, dynamic> json) =>
      _$PlayListVideosContentDetailsFromJson(json);
}

@JsonSerializable(includeIfNull: true, createToJson: false)
class PlayListVideosItem {
  String? kind;
  String? id;
  PlayListVideosSnippet? snippet;
  PlayListVideosContentDetails? contentDetails;

  PlayListVideosItem({this.kind, this.id, this.snippet, this.contentDetails});

  factory PlayListVideosItem.fromJson(Map<String, dynamic> json) =>
      _$PlayListVideosItemFromJson(json);
}

@JsonSerializable(includeIfNull: true, createToJson: false)
class PlayListVideosSnippet {
  DateTime? publishedAt;
  String? channelId;
  String? title;
  String? description;
  MaxThumbnails? thumbnails;
  String? channelTitle;
  String? playlistId;
  int? position;
  String? videoOwnerChannelTitle;
  String? videoOwnerChannelId;

  PlayListVideosSnippet(
      {this.publishedAt,
      this.channelId,
      this.title,
      this.description,
      this.thumbnails,
      this.channelTitle,
      this.playlistId,
      this.position,
      this.videoOwnerChannelTitle,
      this.videoOwnerChannelId});

  factory PlayListVideosSnippet.fromJson(Map<String, dynamic> json) =>
      _$PlayListVideosSnippetFromJson(json);
}
