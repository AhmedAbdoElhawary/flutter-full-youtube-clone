// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'channel_details.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChannelSubDetails _$ChannelSubDetailsFromJson(Map<String, dynamic> json) =>
    ChannelSubDetails(
      kind: json['kind'] as String?,
      tag: json['etag'] as String?,
      items: (json['items'] as List<dynamic>?)
          ?.map((e) => e == null
              ? null
              : ChannelDetailsItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

ChannelDetailsItem _$ChannelDetailsItemFromJson(Map<String, dynamic> json) =>
    ChannelDetailsItem(
      kind: json['kind'] as String?,
      tag: json['etag'] as String?,
      id: json['id'] as String?,
      snippet: json['snippet'] == null
          ? null
          : ChannelSnippet.fromJson(json['snippet'] as Map<String, dynamic>),
      contentDetails: json['contentDetails'] == null
          ? null
          : ChannelContentDetails.fromJson(
              json['contentDetails'] as Map<String, dynamic>),
      statistics: json['statistics'] == null
          ? null
          : ChannelStatistics.fromJson(
              json['statistics'] as Map<String, dynamic>),
    );

ChannelContentDetails _$ChannelContentDetailsFromJson(
        Map<String, dynamic> json) =>
    ChannelContentDetails(
      relatedPlaylists: json['relatedPlaylists'] == null
          ? null
          : RelatedPlaylists.fromJson(
              json['relatedPlaylists'] as Map<String, dynamic>),
    );

RelatedPlaylists _$RelatedPlaylistsFromJson(Map<String, dynamic> json) =>
    RelatedPlaylists(
      likes: json['likes'] as String?,
      uploads: json['uploads'] as String?,
    );

ChannelSnippet _$ChannelSnippetFromJson(Map<String, dynamic> json) =>
    ChannelSnippet(
      title: json['title'] as String?,
      description: json['description'] as String?,
      customUrl: json['customUrl'] as String?,
      publishedAt: json['publishedAt'] == null
          ? null
          : DateTime.parse(json['publishedAt'] as String),
      thumbnails: json['thumbnails'] == null
          ? null
          : ChannelThumbnails.fromJson(
              json['thumbnails'] as Map<String, dynamic>),
      country: json['country'] as String?,
    );

ChannelStatistics _$ChannelStatisticsFromJson(Map<String, dynamic> json) =>
    ChannelStatistics(
      viewCount: json['viewCount'] as String?,
      subscriberCount: json['subscriberCount'] as String?,
      hiddenSubscriberCount: json['hiddenSubscriberCount'] as bool?,
      videoCount: json['videoCount'] as String?,
    );

ChannelThumbnails _$ChannelThumbnailsFromJson(Map<String, dynamic> json) =>
    ChannelThumbnails(
      json['medium'] == null
          ? null
          : ThumbnailDetails.fromJson(json['medium'] as Map<String, dynamic>),
      json['high'] == null
          ? null
          : ThumbnailDetails.fromJson(json['high'] as Map<String, dynamic>),
    );