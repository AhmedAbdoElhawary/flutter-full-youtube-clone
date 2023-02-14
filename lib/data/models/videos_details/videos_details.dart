import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:youtube/data/models/channel_details/channel_details.dart';
import 'package:youtube/data/models/common/page_info/page_info.dart';
import 'package:youtube/data/models/common/thumbnail_details/max_thumbnail_details.dart';

part 'videos_details.g.dart';

@JsonSerializable(includeIfNull: true, createToJson: false)
class VideosDetails {
  @JsonKey(name: "items")
  List<VideoDetailsItem>? videoDetailsItem;
  String? nextPageToken;
  String? prevPageToken;
  PageInfo? pageInfo;

  VideosDetails(this.pageInfo, this.videoDetailsItem, this.nextPageToken,
      this.prevPageToken);

  factory VideosDetails.fromJson(Map<String, dynamic> json) =>
      _$VideosDetailsFromJson(json);
}

@JsonSerializable(includeIfNull: true, createToJson: false)
class VideoDetailsItem {
  VideoDetailsItem(
    this.id,
    this.snippet,
    this.contentDetails,
    this.statistics,
  );

  String? id;
  VideoSnippet? snippet;
  ContentDetails contentDetails;
  VideoStatistics statistics;

  factory VideoDetailsItem.fromJson(Map<String, dynamic> json) =>
      _$VideoDetailsItemFromJson(json);
}

@JsonSerializable(includeIfNull: true, createToJson: false)
class VideoSnippet {
  VideoSnippet(
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
  MaxThumbnails? thumbnails;
  String? channelTitle;
  List<String>? tags;
  String? categoryId;
  String? liveBroadcastContent;
  String? defaultAudioLanguage;

  @JsonKey(includeToJson: false, includeFromJson: false)
  ChannelSubDetails? channelSubDetails;

  factory VideoSnippet.fromJson(Map<String, dynamic> json) =>
      _$VideoSnippetFromJson(json);
}

@JsonSerializable(includeIfNull: true, createToJson: false)
class Localized {
  Localized(this.title, this.description);

  String? title;
  String? description;

  factory Localized.fromJson(Map<String, dynamic> json) =>
      _$LocalizedFromJson(json);
}

@JsonSerializable(includeIfNull: true, createToJson: false)
class ContentDetails {
  ContentDetails(
    this.duration,
    this.dimension,
    this.definition,
    this.caption,
    this.licensedContent,
    this.projection,
  );

  String? duration;
  String? dimension;
  String? definition;
  String? caption;
  bool? licensedContent;
  String? projection;

  factory ContentDetails.fromJson(Map<String, dynamic> json) =>
      _$ContentDetailsFromJson(json);
}

@JsonSerializable(includeIfNull: true, createToJson: false)
class VideoStatistics {
  VideoStatistics(
    this.viewCount,
    this.favoriteCount,
    this.commentCount,
    this.likeCount,
  );

  String? viewCount;
  String? favoriteCount;
  String? commentCount;
  String? likeCount;

  factory VideoStatistics.fromJson(Map<String, dynamic> json) =>
      _$VideoStatisticsFromJson(json);
}
