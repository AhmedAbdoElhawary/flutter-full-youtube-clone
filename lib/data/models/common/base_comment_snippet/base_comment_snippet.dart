import 'package:youtube/data/models/common/base_comment_snippet/author_channel_id.dart';


abstract class BaseCommentSnippet {
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
  DateTime? publishedAt;
  DateTime? updatedAt;

  BaseCommentSnippet(
      this.videoId,
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
      this.updatedAt);

}
