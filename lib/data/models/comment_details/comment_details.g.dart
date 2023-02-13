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
          : CommentSnippet.fromJson(json['snippet'] as Map<String, dynamic>),
    );

CommentSnippet _$CommentSnippetFromJson(Map<String, dynamic> json) =>
    CommentSnippet(
      topLevelComment: json['topLevelComment'] == null
          ? null
          : TopLevelComment.fromJson(
              json['topLevelComment'] as Map<String, dynamic>),
      canReply: json['canReply'] as bool?,
      totalReplyCount: json['totalReplyCount'] as int?,
      isPublic: json['isPublic'] as bool?,
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

TopLevelComment _$TopLevelCommentFromJson(Map<String, dynamic> json) =>
    TopLevelComment(
      id: json['id'] as String?,
      snippet: json['snippet'] == null
          ? null
          : CommentSnippet.fromJson(json['snippet'] as Map<String, dynamic>),
    );
