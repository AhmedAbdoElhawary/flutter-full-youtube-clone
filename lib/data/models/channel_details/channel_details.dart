import 'package:json_annotation/json_annotation.dart';
import 'package:youtube/data/models/common/thumbnail_details/high_thumbnail_details.dart';

part 'channel_details.g.dart';

@JsonSerializable(includeIfNull: true, createToJson: false)
class ChannelSubDetails {
  List<ChannelDetailsItem?>? items;

  ChannelSubDetails({this.items});

  factory ChannelSubDetails.fromJson(Map<String, dynamic> json) =>
      _$ChannelSubDetailsFromJson(json);
}

@JsonSerializable(includeIfNull: true, createToJson: false)
class ChannelDetailsItem {
  String? id;
  ChannelSnippet? snippet;
  ChannelContentDetails? contentDetails;
  ChannelStatistics? statistics;
  BrandingSettings? brandingSettings;
  ChannelDetailsItem(
      {this.id, this.snippet, this.contentDetails, this.statistics});
  factory ChannelDetailsItem.fromJson(Map<String, dynamic> json) =>
      _$ChannelDetailsItemFromJson(json);
}

@JsonSerializable(includeIfNull: true, createToJson: false)
class ChannelContentDetails {
  RelatedPlaylists? relatedPlaylists;

  ChannelContentDetails({this.relatedPlaylists});

  factory ChannelContentDetails.fromJson(Map<String, dynamic> json) =>
      _$ChannelContentDetailsFromJson(json);
}

@JsonSerializable(includeIfNull: true, createToJson: false)
class RelatedPlaylists {
  String? likes;
  String? uploads;

  RelatedPlaylists({this.likes, this.uploads});

  factory RelatedPlaylists.fromJson(Map<String, dynamic> json) =>
      _$RelatedPlaylistsFromJson(json);
}

@JsonSerializable(includeIfNull: true, createToJson: false)
class ChannelSnippet {
  String? title;
  String? description;
  String? customUrl;
  DateTime? publishedAt;
  HighThumbnails? thumbnails;
  String? country;

  ChannelSnippet(
      {this.title,
      this.description,
      this.customUrl,
      this.publishedAt,
      this.thumbnails,
      this.country});

  factory ChannelSnippet.fromJson(Map<String, dynamic> json) =>
      _$ChannelSnippetFromJson(json);
}

@JsonSerializable(includeIfNull: true, createToJson: false)
class ChannelStatistics {
  String? viewCount;
  String? subscriberCount;
  bool? hiddenSubscriberCount;
  String? videoCount;

  ChannelStatistics(
      {this.viewCount,
      this.subscriberCount,
      this.hiddenSubscriberCount,
      this.videoCount});

  factory ChannelStatistics.fromJson(Map<String, dynamic> json) =>
      _$ChannelStatisticsFromJson(json);
}

@JsonSerializable(includeIfNull: true, createToJson: false)
class BrandingSettings {
  String? unsubscribedTrailer;
  String? channelCover;
  BrandingSettings({this.unsubscribedTrailer, this.channelCover});

  factory BrandingSettings.fromJson(Map<String, dynamic> json) =>
      _$BrandingSettingsFromJson(json);
}
