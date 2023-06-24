import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:youtube/data/models/channel_details/channel_details.dart';
import 'package:youtube/data/models/common/page_info/page_info.dart';
import 'package:youtube/data/models/common/thumbnail_details/high_thumbnail_details.dart';

part 'searched_video_details.g.dart';

@JsonSerializable(includeIfNull: true, createToJson: false)
class SearchedVideosDetails {
  @JsonKey(name: "items")
  List<SearchedVideosItem>? videoDetailsItem;
  String? nextPageToken;
  String? prevPageToken;
  PageInfo? pageInfo;

  SearchedVideosDetails(this.pageInfo, this.videoDetailsItem,
      this.nextPageToken, this.prevPageToken);

  factory SearchedVideosDetails.fromJson(Map<String, dynamic> json) =>
      _$SearchedVideosDetailsFromJson(json);
}

@JsonSerializable(includeIfNull: true, createToJson: false)
class SearchedVideosItem {
  SearchedVideosItem(this.id, this.snippet);

  SearchedVideoId? id;
  SearchedVideoSnippet? snippet;

  factory SearchedVideosItem.fromJson(Map<String, dynamic> json) =>
      _$SearchedVideosItemFromJson(json);
}

@JsonSerializable(includeIfNull: true, createToJson: false)
class SearchedVideoSnippet {
  SearchedVideoSnippet(
    this.publishedAt,
    this.channelId,
    this.title,
    this.description,
    this.thumbnails,
    this.channelTitle,
    this.tags,
    this.categoryId,
    this.liveBroadcastContent,
    this.defaultAudioLanguage,
  );

  DateTime? publishedAt;
  String? channelId;
  String? title;
  String? description;
  HighThumbnails? thumbnails;
  String? channelTitle;
  List<String>? tags;
  String? categoryId;
  String? liveBroadcastContent;
  String? defaultAudioLanguage;

  @JsonKey(includeToJson: false, includeFromJson: false)
  ChannelSubDetails? channelSubDetails;

  factory SearchedVideoSnippet.fromJson(Map<String, dynamic> json) =>
      _$SearchedVideoSnippetFromJson(json);
}

@JsonSerializable(includeIfNull: true, createToJson: false)
class SearchedVideoId {
  SearchedVideoId(this.videoId);

  String? videoId;

  factory SearchedVideoId.fromJson(Map<String, dynamic> json) =>
      _$SearchedVideoIdFromJson(json);
}
