// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'searched_video_details.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SearchedVideosDetails _$SearchedVideosDetailsFromJson(
        Map<String, dynamic> json) =>
    SearchedVideosDetails(
      json['pageInfo'] == null
          ? null
          : PageInfo.fromJson(json['pageInfo'] as Map<String, dynamic>),
      (json['items'] as List<dynamic>?)
          ?.map((e) => SearchedVideosItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['nextPageToken'] as String?,
      json['prevPageToken'] as String?,
    );

SearchedVideosItem _$SearchedVideosItemFromJson(Map<String, dynamic> json) =>
    SearchedVideosItem(
      json['id'] == null
          ? null
          : SearchedVideoId.fromJson(json['id'] as Map<String, dynamic>),
      json['snippet'] == null
          ? null
          : SearchedVideoSnippet.fromJson(
              json['snippet'] as Map<String, dynamic>),
    );

SearchedVideoSnippet _$SearchedVideoSnippetFromJson(
        Map<String, dynamic> json) =>
    SearchedVideoSnippet(
      json['publishedAt'] == null
          ? null
          : DateTime.parse(json['publishedAt'] as String),
      json['channelId'] as String?,
      json['title'] as String?,
      json['description'] as String?,
      json['thumbnails'] == null
          ? null
          : HighThumbnails.fromJson(json['thumbnails'] as Map<String, dynamic>),
      json['channelTitle'] as String?,
      (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList(),
      json['categoryId'] as String?,
      json['liveBroadcastContent'] as String?,
      json['defaultAudioLanguage'] as String?,
    );

SearchedVideoId _$SearchedVideoIdFromJson(Map<String, dynamic> json) =>
    SearchedVideoId(
      json['videoId'] as String?,
    );
