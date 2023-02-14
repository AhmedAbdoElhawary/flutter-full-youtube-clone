// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_snippet.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BaseSnippet _$BaseSnippetFromJson(Map<String, dynamic> json) => BaseSnippet(
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
    );
