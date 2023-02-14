// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'suggestion_videos_details.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SuggestionVideosDetails _$SearchedVideosDetailsFromJson(
        Map<String, dynamic> json) =>
    SuggestionVideosDetails(
      items: (json['items'] as List<dynamic>?)
          ?.map((e) => e == null
              ? null
              : SearchedVideosItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

SearchedVideosItem _$SearchedVideosItemFromJson(Map<String, dynamic> json) =>
    SearchedVideosItem(
      id: json['id'] == null
          ? null
          : SearchedVideosId.fromJson(json['id'] as Map<String, dynamic>),
      snippet: json['snippet'] == null
          ? null
          : BaseSnippet.fromJson(json['snippet'] as Map<String, dynamic>),
    );

SearchedVideosId _$SearchedVideosIdFromJson(Map<String, dynamic> json) =>
    SearchedVideosId(
      kind: json['kind'] as String?,
      videoId: json['videoId'] as String?,
    );
