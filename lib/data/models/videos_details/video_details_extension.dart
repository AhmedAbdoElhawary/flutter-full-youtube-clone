import 'package:youtube/core/helpers/reformat/date_reformat.dart';
import 'package:youtube/core/helpers/reformat/views_reformat.dart';
import 'package:youtube/data/models/channel_details/channel_details.dart';
import 'package:youtube/data/models/channel_details/channel_sub_details/channel_sub_details_extension.dart';
import 'package:youtube/data/models/common/thumbnail_details/max_thumbnail_details.dart';
import 'package:youtube/data/models/videos_details/videos_details.dart';

/// [getChannelCustomTitle] @title
extension VideoDetailsItemExtension on VideoDetailsItem {
  String getVideoTitle() => snippet?.title ?? "";
  String getVideoPublishedTime() =>
      DateReformat.fullDigitFormat(snippet?.publishedAt);
  String getVideoDescription() => snippet?.description ?? "";
  MaxThumbnails? getVideoThumbnails() => snippet?.thumbnails;
  String getVideoViewsCount() => _viewsCount(statistics.viewCount);
  String getVideoLikesCount() => _viewsCount(statistics.likeCount);
  String getVideoCommentsCount() => _viewsCount(statistics.commentCount);

  ChannelDetailsItem? getChannelSubDetails() =>
      snippet?.channelSubDetails?.items?[0];
  String getChannelName() => snippet?.channelTitle ?? "";
  String getChannelId() => snippet?.channelId ?? "";
  String getChannelBio() => getChannelSubDetails()?.getBio() ?? "";
  String getChannelProfileImageUrl() =>
      getChannelSubDetails()?.getProfileImageUrl() ?? "";
  String getCustomUserName() =>
      getChannelSubDetails()?.getCustomUserName() ?? "";
  String getChannelCountry() =>
      getChannelSubDetails()?.getChannelCountry() ?? "";
  String getPublishedTimeOfChannel() =>
      getChannelSubDetails()?.getPublishedTime() ?? "";
  String getChannelVideosViews() =>
      getChannelSubDetails()?.getVideosViewsCount() ?? "";
  String getSubscribersCount() =>
      getChannelSubDetails()?.getSubscribersCount() ?? "";
  String getChannelVideosCount() =>
      getChannelSubDetails()?.getVideosCount() ?? "";

  String getVideoDuration() {
    String? duration = contentDetails.duration;
    if (duration == null) return "";
    String formatDuration = CountsReformat.videoDurationFormat(duration);
    return formatDuration;
  }

  String _viewsCount(String? views) {
    if (views == null) return "";
    String formatViews = CountsReformat.basicCountFormat(views);
    return formatViews;
  }
}
