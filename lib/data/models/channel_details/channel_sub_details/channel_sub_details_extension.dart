import 'package:youtube/core/functions/reformat/date_reformat.dart';
import 'package:youtube/core/functions/reformat/views_reformat.dart';
import 'package:youtube/data/models/channel_details/channel_details.dart';

/// [getCustomTitle] @title
extension ChannelDetailsItemExtension on ChannelDetailsItem {
  String getName() => snippet?.title ?? "";
  String getBio() => snippet?.description ?? "";

  String getCustomUserName() => snippet?.customUrl ?? "";
  String getProfileImageUrl() => snippet?.thumbnails?.high?.url ?? "";
  String getChannelCoverUrl() => brandingSettings?.channelCover ?? "";
  String getMainVideoId() => brandingSettings?.unsubscribedTrailer ?? "";

  String getChannelCountry() => snippet?.country ?? "";
  String getPublishedTime() =>
      DateReformat.oneDigitFormat(snippet?.publishedAt);

  String getVideosViewsCount() => _viewsCount(statistics?.viewCount);
  String getSubscribersCount() => _viewsCount(statistics?.subscriberCount);
  String getVideosCount() => _viewsCount(statistics?.videoCount);

  String _viewsCount(String? views) {
    if (views == null) return "";
    String formatViews = CountsReformat.basicCountFormat(views);
    return formatViews;
  }
}
