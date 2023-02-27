import 'package:youtube/core/functions/reformat/date_reformat.dart';
import 'package:youtube/data/models/comment_details/comment_details.dart';

extension CommentDetailsExtension on CommentDetailsItem {
  int getTotalReplyCount() => snippet?.totalReplyCount ?? 0;
  String getVideoId() => snippet?.videoId ?? "";
  String getAuthorProfileImageUrl() =>
      snippet?.topLevelComment?.snippet?.authorProfileImageUrl ?? "";
  String getAuthorDisplayName() =>
      snippet?.topLevelComment?.snippet?.authorDisplayName ?? "";
  int getLikeCount() => snippet?.topLevelComment?.snippet?.likeCount ?? 0;
  String getCommentText() =>
      snippet?.topLevelComment?.snippet?.textOriginal ?? "";
  String getAuthorChannelId() =>
      snippet?.topLevelComment?.snippet?.authorChannelId?.value ?? "";

  String getCommentPublishedTime() => DateReformat.oneDigitFormat(
      snippet?.topLevelComment?.snippet?.publishedAt ?? "");
}
