import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:youtube/data/models/channel_details/channel_details.dart';
import 'package:youtube/data/models/common/thumbnail_details/thumbnail_details.dart';

part 'video_details.g.dart';

@JsonSerializable(includeIfNull: true, createToJson: false)
class VideosDetails {
  @JsonKey(name: "items")
  List<VideoDetailsItem>? videoDetailsItem;
  VideosDetails(this.videoDetailsItem);

  factory VideosDetails.fromJson(Map<String, dynamic> json) =>
      _$VideosDetailsFromJson(json);
}

@JsonSerializable(includeIfNull: true, createToJson: false,)
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
    this.defaultLanguage,
    this.localized,
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
  String? defaultLanguage;
  Localized? localized;
  String? defaultAudioLanguage;

  @JsonKey(includeToJson: false,includeFromJson: false)
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
class MaxThumbnails {
  MaxThumbnails(
      this.thumbnailsDefault, this.medium, this.high, this.standard, this.max);

  ThumbnailDetails? thumbnailsDefault;
  ThumbnailDetails? medium;
  ThumbnailDetails? high;
  ThumbnailDetails? standard;

  @JsonKey(name: "maxres")
  ThumbnailDetails? max;

  factory MaxThumbnails.fromJson(Map<String, dynamic> json) =>
      _$MaxThumbnailsFromJson(json);
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
