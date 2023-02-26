import 'package:youtube/core/functions/reformat/date_reformat.dart';
import 'package:youtube/data/models/channel_details/my_subscriptions/my_subscriptions_details.dart';
import 'package:youtube/data/models/common/thumbnail_details/max_thumbnail_details.dart';

extension MySubscriptionItemExtension on MySubscriptionsItem {
  String getChannelName() => snippet?.title ?? "";
  String getChannelPublishedTime() =>
      DateReformat.oneDigitFormat(snippet?.publishedAt);
  String getChannelBio() => snippet?.description ?? "";
  String getChannelId() => snippet?.resourceId?.channelId ?? "";

  MaxThumbnails? getChannelThumbnails() => snippet?.thumbnails;
  String getChannelMaxUrl() => snippet?.thumbnails?.max?.url ?? "";
  String getChannelHighUrl() => snippet?.thumbnails?.high?.url ?? "";
}
