import 'package:get/get.dart';
import 'package:youtube/data/models/channel_details/my_subscriptions/my_subscription_item_extension.dart';
import 'package:youtube/data/models/channel_details/my_subscriptions/my_subscriptions_details.dart';

class SubscriptionsPageLogic extends GetxController {
  final Rx<int?> _selectedChannelIndex = Rxn<int?>();
  final Rx<MySubscriptionsDetails?> _allSubscribedChannels =
      Rxn<MySubscriptionsDetails?>();
  final Rx<MySubscriptionsItem?> _selectedChannelItemDetails =
      Rxn<MySubscriptionsItem?>();

  final Rx<List<String>> _allSubscribedIds = Rx<List<String>>([]);
  final Rx<List<String>> _allSubscribedChannelsIds = Rx<List<String>>([]);

  int? get selectedChannelIndex => _selectedChannelIndex.value;

  set selectedChannelIndex(int? value) {
    _selectedChannelIndex.value = value;
    update(["update-selected-channel"]);
  }

  MySubscriptionsDetails? get allSubscribedChannels =>
      _allSubscribedChannels.value;

  set allSubscribedChannels(MySubscriptionsDetails? value) {
    _allSubscribedChannels.value = value;
    if (value != null) {
      for (final v in value.items ?? <MySubscriptionsItem?>[]) {
        String? id = v?.id;
        String? channelId = v?.getChannelId();
        if (id != null && channelId != null) {
          _allSubscribedIds.value.add(id);
          _allSubscribedChannelsIds.value.add(channelId);
        }
      }
    }

    update(["update-subscribed-channels"]);
  }

  List<String> get allSubscribedIds => _allSubscribedIds.value;
  List<String> get allSubscribedChannelsIds => _allSubscribedChannelsIds.value;

  MySubscriptionsItem? get selectedChannelItemDetails =>
      _selectedChannelItemDetails.value;

  set selectedChannelItemDetails(MySubscriptionsItem? value) {
    _selectedChannelItemDetails.value = value;
    update(["update-selected-channel"]);
  }
}
