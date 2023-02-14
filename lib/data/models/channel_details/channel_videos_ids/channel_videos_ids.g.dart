// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'channel_videos_ids.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChannelVideosIds _$ChannelVideosIdsFromJson(Map<String, dynamic> json) =>
    ChannelVideosIds(
      json['nextPageToken'] as String?,
      json['pageInfo'] == null
          ? null
          : PageInfo.fromJson(json['pageInfo'] as Map<String, dynamic>),
      (json['items'] as List<dynamic>?)
          ?.map((e) => e == null
              ? null
              : ChannelVideosIdsItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    )..prevPageToken = json['prevPageToken'] as String?;

ChannelVideoId _$ChannelVideoIdFromJson(Map<String, dynamic> json) =>
    ChannelVideoId(
      json['kind'] as String?,
      json['videoId'] as String?,
    );

ChannelVideosIdsItem _$ChannelVideosIdsItemFromJson(
        Map<String, dynamic> json) =>
    ChannelVideosIdsItem(
      json['id'] == null
          ? null
          : ChannelVideoId.fromJson(json['id'] as Map<String, dynamic>),
    );
