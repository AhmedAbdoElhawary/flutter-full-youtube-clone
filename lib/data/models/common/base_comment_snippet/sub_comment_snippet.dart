
import 'package:json_annotation/json_annotation.dart';
import 'package:youtube/data/models/common/base_comment_snippet/author_channel_id.dart';

part 'sub_comment_snippet.g.dart';

@JsonSerializable(includeIfNull: true, createToJson: false)
class SubCommentSnippet {
  String? videoId;
  String? textDisplay;
  String? textOriginal;
  String? authorDisplayName;
  String? authorProfileImageUrl;
  String? authorChannelUrl;
  AuthorChannelId? authorChannelId;
  bool? canRate;
  String? viewerRating;
  int? likeCount;
  String? publishedAt;
  String? updatedAt;

  SubCommentSnippet(
      {this.videoId,
        this.textDisplay,
        this.textOriginal,
        this.authorDisplayName,
        this.authorProfileImageUrl,
        this.authorChannelUrl,
        this.authorChannelId,
        this.canRate,
        this.viewerRating,
        this.likeCount,
        this.publishedAt,
        this.updatedAt});
  factory SubCommentSnippet.fromJson(Map<String, dynamic> json) =>
      _$SubCommentSnippetFromJson(json);
}
