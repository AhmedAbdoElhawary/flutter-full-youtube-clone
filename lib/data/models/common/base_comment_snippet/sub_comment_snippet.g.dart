// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sub_comment_snippet.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SubCommentSnippet _$SubCommentSnippetFromJson(Map<String, dynamic> json) =>
    SubCommentSnippet(
      videoId: json['videoId'] as String?,
      textDisplay: json['textDisplay'] as String?,
      textOriginal: json['textOriginal'] as String?,
      authorDisplayName: json['authorDisplayName'] as String?,
      authorProfileImageUrl: json['authorProfileImageUrl'] as String?,
      authorChannelUrl: json['authorChannelUrl'] as String?,
      authorChannelId: json['authorChannelId'] == null
          ? null
          : AuthorChannelId.fromJson(
              json['authorChannelId'] as Map<String, dynamic>),
      canRate: json['canRate'] as bool?,
      viewerRating: json['viewerRating'] as String?,
      likeCount: json['likeCount'] as int?,
      publishedAt: json['publishedAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
    );
