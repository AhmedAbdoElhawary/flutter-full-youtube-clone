// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'max_thumbnail_details.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MaxThumbnails _$MaxThumbnailsFromJson(Map<String, dynamic> json) =>
    MaxThumbnails(
      json['thumbnailsDefault'] == null
          ? null
          : ThumbnailDetails.fromJson(
              json['thumbnailsDefault'] as Map<String, dynamic>),
      json['medium'] == null
          ? null
          : ThumbnailDetails.fromJson(json['medium'] as Map<String, dynamic>),
      json['high'] == null
          ? null
          : ThumbnailDetails.fromJson(json['high'] as Map<String, dynamic>),
      json['standard'] == null
          ? null
          : ThumbnailDetails.fromJson(json['standard'] as Map<String, dynamic>),
      json['maxres'] == null
          ? null
          : ThumbnailDetails.fromJson(json['maxres'] as Map<String, dynamic>),
    );
