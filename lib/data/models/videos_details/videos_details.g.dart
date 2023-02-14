// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'videos_details.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VideosDetails _$VideosDetailsFromJson(Map<String, dynamic> json) =>
    VideosDetails(
      json['pageInfo'] == null
          ? null
          : PageInfo.fromJson(json['pageInfo'] as Map<String, dynamic>),
      (json['items'] as List<dynamic>?)
          ?.map((e) => VideoDetailsItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['nextPageToken'] as String?,
      json['prevPageToken'] as String?,
    );

VideoDetailsItem _$VideoDetailsItemFromJson(Map<String, dynamic> json) =>
    VideoDetailsItem(
      json['id'] as String?,
      json['snippet'] == null
          ? null
          : VideoSnippet.fromJson(json['snippet'] as Map<String, dynamic>),
      ContentDetails.fromJson(json['contentDetails'] as Map<String, dynamic>),
      VideoStatistics.fromJson(json['statistics'] as Map<String, dynamic>),
    );

VideoSnippet _$VideoSnippetFromJson(Map<String, dynamic> json) => VideoSnippet(
      json['publishedAt'] == null
          ? null
          : DateTime.parse(json['publishedAt'] as String),
      json['channelId'] as String?,
      json['title'] as String?,
      json['description'] as String?,
      json['thumbnails'] == null
          ? null
          : MaxThumbnails.fromJson(json['thumbnails'] as Map<String, dynamic>),
      json['channelTitle'] as String?,
      (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList(),
      json['categoryId'] as String?,
      json['liveBroadcastContent'] as String?,
      json['defaultAudioLanguage'] as String?,
    );

Localized _$LocalizedFromJson(Map<String, dynamic> json) => Localized(
      json['title'] as String?,
      json['description'] as String?,
    );

ContentDetails _$ContentDetailsFromJson(Map<String, dynamic> json) =>
    ContentDetails(
      json['duration'] as String?,
      json['dimension'] as String?,
      json['definition'] as String?,
      json['caption'] as String?,
      json['licensedContent'] as bool?,
      json['projection'] as String?,
    );

VideoStatistics _$VideoStatisticsFromJson(Map<String, dynamic> json) =>
    VideoStatistics(
      json['viewCount'] as String?,
      json['favoriteCount'] as String?,
      json['commentCount'] as String?,
      json['likeCount'] as String?,
    );
