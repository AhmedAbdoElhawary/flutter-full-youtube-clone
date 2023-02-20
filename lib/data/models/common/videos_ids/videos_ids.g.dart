// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'videos_ids.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VideosIdsDetails _$VideosIdsDetailsFromJson(Map<String, dynamic> json) =>
    VideosIdsDetails(
      json['nextPageToken'] as String?,
      json['prevPageToken'] as String?,
      json['pageInfo'] == null
          ? null
          : PageInfo.fromJson(json['pageInfo'] as Map<String, dynamic>),
      (json['items'] as List<dynamic>?)
          ?.map((e) => e == null
              ? null
              : VideoIdItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

VideoIdItem _$VideoIdItemFromJson(Map<String, dynamic> json) => VideoIdItem(
      json['id'] == null
          ? null
          : VideoIdItemDetails.fromJson(json['id'] as Map<String, dynamic>),
    );

VideoIdItemDetails _$VideoIdItemDetailsFromJson(Map<String, dynamic> json) =>
    VideoIdItemDetails(
      json['kind'] as String?,
      json['videoId'] as String?,
    );
