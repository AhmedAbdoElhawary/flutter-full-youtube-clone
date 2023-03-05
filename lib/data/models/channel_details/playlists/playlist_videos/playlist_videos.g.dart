// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'playlist_videos.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PlayListVideos _$PlayListVideosFromJson(Map<String, dynamic> json) =>
    PlayListVideos(
      items: (json['items'] as List<dynamic>?)
          ?.map((e) => e == null
              ? null
              : PlayListVideos.fromJson(e as Map<String, dynamic>))
          .toList(),
      pageInfo: json['pageInfo'] == null
          ? null
          : PageInfo.fromJson(json['pageInfo'] as Map<String, dynamic>),
    );

PlayListVideosContentDetails _$PlayListVideosContentDetailsFromJson(
        Map<String, dynamic> json) =>
    PlayListVideosContentDetails(
      videoId: json['videoId'] as String?,
      videoPublishedAt: json['videoPublishedAt'] == null
          ? null
          : DateTime.parse(json['videoPublishedAt'] as String),
    );

PlayListVideosItem _$PlayListVideosItemFromJson(Map<String, dynamic> json) =>
    PlayListVideosItem(
      kind: json['kind'] as String?,
      id: json['id'] as String?,
      snippet: json['snippet'] == null
          ? null
          : PlayListVideosSnippet.fromJson(
              json['snippet'] as Map<String, dynamic>),
      contentDetails: json['contentDetails'] == null
          ? null
          : PlayListVideosContentDetails.fromJson(
              json['contentDetails'] as Map<String, dynamic>),
    );

PlayListVideosSnippet _$PlayListVideosSnippetFromJson(
        Map<String, dynamic> json) =>
    PlayListVideosSnippet(
      publishedAt: json['publishedAt'] == null
          ? null
          : DateTime.parse(json['publishedAt'] as String),
      channelId: json['channelId'] as String?,
      title: json['title'] as String?,
      description: json['description'] as String?,
      thumbnails: json['thumbnails'] == null
          ? null
          : MaxThumbnails.fromJson(json['thumbnails'] as Map<String, dynamic>),
      channelTitle: json['channelTitle'] as String?,
      playlistId: json['playlistId'] as String?,
      position: json['position'] as int?,
      videoOwnerChannelTitle: json['videoOwnerChannelTitle'] as String?,
      videoOwnerChannelId: json['videoOwnerChannelId'] as String?,
    );
