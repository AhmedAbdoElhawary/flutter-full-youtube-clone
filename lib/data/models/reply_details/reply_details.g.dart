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
          : SubCommentSnippet.fromJson(json['snippet'] as Map<String, dynamic>),
    );
