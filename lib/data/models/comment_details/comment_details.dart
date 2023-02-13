import 'package:json_annotation/json_annotation.dart';
import 'package:youtube/data/models/common/base_comment_snippet/sub_comment_snippet.dart';
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
  MainCommentSnippet? snippet;

  CommentDetailsItem({this.id, this.snippet});

  factory CommentDetailsItem.fromJson(Map<String, dynamic> json) =>
      _$CommentDetailsItemFromJson(json);
}

@JsonSerializable(includeIfNull: true, createToJson: false)
class TopLevelComment {
  String? id;
  SubCommentSnippet? snippet;

  TopLevelComment({this.id, this.snippet});

  factory TopLevelComment.fromJson(Map<String, dynamic> json) =>
      _$TopLevelCommentFromJson(json);
}

@JsonSerializable(includeIfNull: true, createToJson: false)
class MainCommentSnippet {
  String? videoId;
  TopLevelComment? topLevelComment;
  bool? canReply;
  int? totalReplyCount;
  bool? isPublic;

  MainCommentSnippet(
      {this.videoId,
      this.topLevelComment,
      this.canReply,
      this.totalReplyCount,
      this.isPublic});

  factory MainCommentSnippet.fromJson(Map<String, dynamic> json) =>
      _$MainCommentSnippetFromJson(json);
}
