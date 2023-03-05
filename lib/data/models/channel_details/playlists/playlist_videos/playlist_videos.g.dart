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
              : PlayListVideosItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      pageInfo: json['pageInfo'] == null
          ? null
          : PageInfo.fromJson(json['pageInfo'] as Map<String, dynamic>),
      nextPageToken: json['nextPageToken'] as String?,
      prevPageToken: json['prevPageToken'] as String?,
    );
