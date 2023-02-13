// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reply_details.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReplyDetails _$ReplyDetailsFromJson(Map<String, dynamic> json) => ReplyDetails(
      nextPageToken: json['nextPageToken'] as String?,
      pageInfo: json['pageInfo'] == null
          ? null
          : PageInfo.fromJson(json['pageInfo'] as Map<String, dynamic>),
      items: (json['items'] as List<dynamic>?)
          ?.map((e) =>
              e == null ? null : ReplyItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

ReplyItem _$ReplyItemFromJson(Map<String, dynamic> json) => ReplyItem(
      id: json['id'] as String?,
      replies: json['replies'] == null
          ? null
          : Replies.fromJson(json['replies'] as Map<String, dynamic>),
    );

Replies _$RepliesFromJson(Map<String, dynamic> json) => Replies(
      comments: (json['comments'] as List<dynamic>?)
          ?.map((e) => e == null
              ? null
              : ReplyComment.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

ReplyComment _$ReplyCommentFromJson(Map<String, dynamic> json) => ReplyComment(
      kind: json['kind'] as String?,
      id: json['id'] as String?,
      snippet: json['snippet'] == null
          ? null
          : ReplySnippet.fromJson(json['snippet'] as Map<String, dynamic>),
    );

ReplySnippet _$ReplySnippetFromJson(Map<String, dynamic> json) => ReplySnippet(
      parentId: json['parentId'] as String?,
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
      publishedAt: json['publishedAt'] == null
          ? null
          : DateTime.parse(json['publishedAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
    );
