// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'high_thumbnail_details.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HighThumbnails _$HighThumbnailsFromJson(Map<String, dynamic> json) =>
    HighThumbnails(
      json['medium'] == null
          ? null
          : ThumbnailDetails.fromJson(json['medium'] as Map<String, dynamic>),
      json['high'] == null
          ? null
          : ThumbnailDetails.fromJson(json['high'] as Map<String, dynamic>),
    );
