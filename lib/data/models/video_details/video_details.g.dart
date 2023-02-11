// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'video_details.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VideoDetails _$VideoDetailsFromJson(Map<String, dynamic> json) => VideoDetails(
      json['kind'] as String?,
      json['etag'] as String?,
      (json['items'] as List<dynamic>?)
          ?.map((e) => VideoDetailsItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$VideoDetailsToJson(VideoDetails instance) =>
    <String, dynamic>{
      'kind': instance.kind,
      'etag': instance.tag,
      'items': instance.videoDetailsItem,
    };

VideoDetailsItem _$VideoDetailsItemFromJson(Map<String, dynamic> json) =>
    VideoDetailsItem(
      json['kind'] as String?,
      json['etag'] as String?,
      json['id'] as String?,
      json['snippet'] == null
          ? null
          : Snippet.fromJson(json['snippet'] as Map<String, dynamic>),
      ContentDetails.fromJson(json['contentDetails'] as Map<String, dynamic>),
      Statistics.fromJson(json['statistics'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$VideoDetailsItemToJson(VideoDetailsItem instance) =>
    <String, dynamic>{
      'kind': instance.kind,
      'etag': instance.tag,
      'id': instance.id,
      'snippet': instance.snippet,
      'contentDetails': instance.contentDetails,
      'statistics': instance.statistics,
    };

Snippet _$SnippetFromJson(Map<String, dynamic> json) => Snippet(
      json['publishedAt'] == null
          ? null
          : DateTime.parse(json['publishedAt'] as String),
      json['channelId'] as String?,
      json['title'] as String?,
      json['description'] as String?,
      json['thumbnails'] == null
          ? null
          : Thumbnails.fromJson(json['thumbnails'] as Map<String, dynamic>),
      json['channelTitle'] as String?,
      (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList(),
      json['categoryId'] as String?,
      json['liveBroadcastContent'] as String?,
      json['defaultLanguage'] as String?,
      json['localized'] == null
          ? null
          : Localized.fromJson(json['localized'] as Map<String, dynamic>),
      json['defaultAudioLanguage'] as String?,
    );

Map<String, dynamic> _$SnippetToJson(Snippet instance) => <String, dynamic>{
      'publishedAt': instance.publishedAt?.toIso8601String(),
      'channelId': instance.channelId,
      'title': instance.title,
      'description': instance.description,
      'thumbnails': instance.thumbnails,
      'channelTitle': instance.channelTitle,
      'tags': instance.tags,
      'categoryId': instance.categoryId,
      'liveBroadcastContent': instance.liveBroadcastContent,
      'defaultLanguage': instance.defaultLanguage,
      'localized': instance.localized,
      'defaultAudioLanguage': instance.defaultAudioLanguage,
    };

Localized _$LocalizedFromJson(Map<String, dynamic> json) => Localized(
      json['title'] as String?,
      json['description'] as String?,
    );

Map<String, dynamic> _$LocalizedToJson(Localized instance) => <String, dynamic>{
      'title': instance.title,
      'description': instance.description,
    };

Thumbnails _$ThumbnailsFromJson(Map<String, dynamic> json) => Thumbnails(
      json['thumbnailsDefault'] == null
          ? null
          : Default.fromJson(json['thumbnailsDefault'] as Map<String, dynamic>),
      json['medium'] == null
          ? null
          : Default.fromJson(json['medium'] as Map<String, dynamic>),
      json['high'] == null
          ? null
          : Default.fromJson(json['high'] as Map<String, dynamic>),
      json['standard'] == null
          ? null
          : Default.fromJson(json['standard'] as Map<String, dynamic>),
      json['maxres'] == null
          ? null
          : Default.fromJson(json['maxres'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ThumbnailsToJson(Thumbnails instance) =>
    <String, dynamic>{
      'thumbnailsDefault': instance.thumbnailsDefault,
      'medium': instance.medium,
      'high': instance.high,
      'standard': instance.standard,
      'maxres': instance.max,
    };

Default _$DefaultFromJson(Map<String, dynamic> json) => Default(
      json['url'] as String?,
      json['width'] as int?,
      json['height'] as int?,
    );

Map<String, dynamic> _$DefaultToJson(Default instance) => <String, dynamic>{
      'url': instance.url,
      'width': instance.width,
      'height': instance.height,
    };

PageInfo _$PageInfoFromJson(Map<String, dynamic> json) => PageInfo(
      json['totalResults'] as int?,
      json['resultsPerPage'] as int?,
    );

Map<String, dynamic> _$PageInfoToJson(PageInfo instance) => <String, dynamic>{
      'totalResults': instance.totalResults,
      'resultsPerPage': instance.resultsPerPage,
    };

ContentDetails _$ContentDetailsFromJson(Map<String, dynamic> json) =>
    ContentDetails(
      json['duration'] as String?,
      json['dimension'] as String?,
      json['definition'] as String?,
      json['caption'] as String?,
      json['licensedContent'] as bool?,
      json['projection'] as String?,
    );

Map<String, dynamic> _$ContentDetailsToJson(ContentDetails instance) =>
    <String, dynamic>{
      'duration': instance.duration,
      'dimension': instance.dimension,
      'definition': instance.definition,
      'caption': instance.caption,
      'licensedContent': instance.licensedContent,
      'projection': instance.projection,
    };

Statistics _$StatisticsFromJson(Map<String, dynamic> json) => Statistics(
      json['viewCount'] as String?,
      json['favoriteCount'] as String?,
      json['commentCount'] as String?,
      json['likeCount'] as String?,
    );

Map<String, dynamic> _$StatisticsToJson(Statistics instance) =>
    <String, dynamic>{
      'viewCount': instance.viewCount,
      'favoriteCount': instance.favoriteCount,
      'commentCount': instance.commentCount,
      'likeCount': instance.likeCount,
    };
