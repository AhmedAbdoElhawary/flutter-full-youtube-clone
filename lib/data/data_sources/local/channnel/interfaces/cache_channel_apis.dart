import 'package:youtube/data/models/channel_details/channel_details.dart';

import '../../../../../domain/entities/cache_items/cached_item.dart';
import '../../../../models/channel_details/my_subscriptions/my_subscriptions_details.dart';

part '../implements/cache_channel_apis_impl.dart';

abstract class CacheChannelAPIs {
  Future<MySubscriptionsDetails?> getMySubscriptionsChannels();
  Future<void> saveMySubscriptionsChannels(MySubscriptionsDetails subscriptions);
  Future<void> clearMySubscriptionsChannels();

  Future<ChannelSubDetails?> getMyChannelInfo();
  Future<void> saveMyChannelInfo(ChannelSubDetails details);
  Future<void> clearMyChannelInfo();
}
