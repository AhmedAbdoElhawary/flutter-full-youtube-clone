part of 'single_video_cubit.dart';

@freezed
class SingleVideoState with _$SingleVideoState {
  const factory SingleVideoState.initial() = _Initial;

  const factory SingleVideoState.videoInfoLoading() = VideoInfoLoading;

  const factory SingleVideoState.videoDetailsLoaded(
      VideosDetails videoDetails) = VideoDetailsLoaded;

  const factory SingleVideoState.getVideoRatingLoaded(
      RatingDetails ratingDetails) = GetVideoRatingLoaded;

  const factory SingleVideoState.ratingVideoLoaded() = RatingVideoLoaded;

  const factory SingleVideoState.firstCommentLoaded(
      CommentDetails firstCommentDetails) = FirstCommentLoaded;

  const factory SingleVideoState.allCommentLoaded(
      CommentDetails allCommentDetails) = AllCommentLoaded;

  const factory SingleVideoState.allRepliesLoaded(
      ReplyDetails allRepliesDetails) = AllRepliesLoaded;

  const factory SingleVideoState.videoInfoError(
      NetworkExceptionModel networkExceptions) = VideoInfoError;
}
