import 'package:json_annotation/json_annotation.dart';
import 'package:youtube/data/models/common/base_comment_snippet/author_channel_id.dart';
import 'package:youtube/data/models/common/base_comment_snippet/base_comment_snippet.dart';
import 'package:youtube/data/models/common/page_info/page_info.dart';
part 'comment_details.g.dart';

@JsonSerializable(includeIfNull: true, createToJson: false)
class CommentDetails {
  String? nextPageToken;
  PageInfo? pageInfo;
  List<CommentDetailsItem?>? items;

  CommentDetails({this.nextPageToken, this.pageInfo, this.items});

  factory CommentDetails.fromJson(Map<String, dynamic> json) =>
      _$CommentDetailsFromJson(json);
}

@JsonSerializable(includeIfNull: true, createToJson: false)
class CommentDetailsItem {
  String? id;
  CommentSnippet? snippet;

  CommentDetailsItem({this.id, this.snippet});

  factory CommentDetailsItem.fromJson(Map<String, dynamic> json) =>
      _$CommentDetailsItemFromJson(json);
}

@JsonSerializable(includeIfNull: true, createToJson: false)
class CommentSnippet extends BaseCommentSnippet {
  TopLevelComment? topLevelComment;
  bool? canReply;
  int? totalReplyCount;
  bool? isPublic;
  CommentSnippet(
      {this.topLevelComment,
      this.canReply,
      this.totalReplyCount,
      this.isPublic,
      String? videoId,
      String? textDisplay,
      String? textOriginal,
      String? authorDisplayName,
      String? authorProfileImageUrl,
      String? authorChannelUrl,
      AuthorChannelId? authorChannelId,
      bool? canRate,
      String? viewerRating,
      int? likeCount,
      DateTime? publishedAt,
      DateTime? updatedAt})
      : super(
            videoId,
            textDisplay,
            textOriginal,
            authorDisplayName,
            authorProfileImageUrl,
            authorChannelUrl,
            authorChannelId,
            canRate,
            viewerRating,
            likeCount,
            publishedAt,
            updatedAt);

  factory CommentSnippet.fromJson(Map<String, dynamic> json) =>
      _$CommentSnippetFromJson(json);
}

@JsonSerializable(includeIfNull: true, createToJson: false)
class TopLevelComment {
  String? id;
  CommentSnippet? snippet;

  TopLevelComment({this.id, this.snippet});

  factory TopLevelComment.fromJson(Map<String, dynamic> json) =>
      _$TopLevelCommentFromJson(json);
}
