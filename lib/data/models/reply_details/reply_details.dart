import 'package:json_annotation/json_annotation.dart';
import 'package:youtube/data/models/common/base_comment_snippet/author_channel_id.dart';
import 'package:youtube/data/models/common/base_comment_snippet/base_comment_snippet.dart';
import 'package:youtube/data/models/common/page_info/page_info.dart';

part 'reply_details.g.dart';

@JsonSerializable(includeIfNull: true, createToJson: false)
class ReplyDetails {
  PageInfo? pageInfo;
  List<ReplyItem?>? items;
  String? nextPageToken;

  ReplyDetails({this.nextPageToken, this.pageInfo, this.items});

  factory ReplyDetails.fromJson(Map<String, dynamic> json) =>
      _$ReplyDetailsFromJson(json);
}

@JsonSerializable(includeIfNull: true, createToJson: false)
class ReplyItem {
  String? id;
  Replies? replies;

  ReplyItem({this.id, this.replies});

  factory ReplyItem.fromJson(Map<String, dynamic> json) =>
      _$ReplyItemFromJson(json);
}

@JsonSerializable(includeIfNull: true, createToJson: false)
class Replies {
  List<ReplyComment?>? comments;

  Replies({this.comments});

  factory Replies.fromJson(Map<String, dynamic> json) =>
      _$RepliesFromJson(json);
}

@JsonSerializable(includeIfNull: true, createToJson: false)
class ReplyComment {
  String? kind;
  String? id;
  ReplySnippet? snippet;

  ReplyComment({this.kind, this.id, this.snippet});

  factory ReplyComment.fromJson(Map<String, dynamic> json) =>
      _$ReplyCommentFromJson(json);
}

@JsonSerializable(includeIfNull: true, createToJson: false)
class ReplySnippet extends BaseCommentSnippet {
  String? parentId;

  ReplySnippet(
      {this.parentId,
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

  factory ReplySnippet.fromJson(Map<String, dynamic> json) =>
      _$ReplySnippetFromJson(json);
}
