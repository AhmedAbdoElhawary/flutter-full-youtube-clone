// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment_details.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CommentDetails _$CommentDetailsFromJson(Map<String, dynamic> json) =>
    CommentDetails(
      nextPageToken: json['nextPageToken'] as String?,
      pageInfo: json['pageInfo'] == null
          ? null
          : PageInfo.fromJson(json['pageInfo'] as Map<String, dynamic>),
      items: (json['items'] as List<dynamic>?)
          ?.map((e) => e == null
              ? null
              : CommentDetailsItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

CommentDetailsItem _$CommentDetailsItemFromJson(Map<String, dynamic> json) =>
    CommentDetailsItem(
      id: json['id'] as String?,
      snippet: json['snippet'] == null
          ? null
          : MainCommentSnippet.fromJson(
              json['snippet'] as Map<String, dynamic>),
    );

TopLevelComment _$TopLevelCommentFromJson(Map<String, dynamic> json) =>
    TopLevelComment(
      id: json['id'] as String?,
      snippet: json['snippet'] == null
          ? null
          : SubCommentSnippet.fromJson(json['snippet'] as Map<String, dynamic>),
    );

MainCommentSnippet _$MainCommentSnippetFromJson(Map<String, dynamic> json) =>
    MainCommentSnippet(
      videoId: json['videoId'] as String?,
      topLevelComment: json['topLevelComment'] == null
          ? null
          : TopLevelComment.fromJson(
              json['topLevelComment'] as Map<String, dynamic>),
      canReply: json['canReply'] as bool?,
      totalReplyCount: json['totalReplyCount'] as int?,
      isPublic: json['isPublic'] as bool?,
    );
