import 'package:get/get.dart';
import 'package:youtube/data/models/channel_details/my_subscriptions/my_subscriptions_details.dart';

class SubscriptionsPageLogic extends GetxController {
  final Rx<int?> _selectedChannelIndex = Rxn<int?>();
  final Rx<MySubscriptionsDetails?> _allSubscribedChannels =
      Rxn<MySubscriptionsDetails?>();
  final Rx<MySubscriptionsItem?> _selectedChannelItemDetails =
      Rxn<MySubscriptionsItem?>();

  int? get selectedChannelIndex => _selectedChannelIndex.value;

  set selectedChannelIndex(int? value) {
    _selectedChannelIndex.value = value;
    update(["update-selected-channel"]);
  }

  MySubscriptionsDetails? get allSubscribedChannels =>
      _allSubscribedChannels.value;

  set allSubscribedChannels(MySubscriptionsDetails? value) {
    _allSubscribedChannels.value = value;
    update(["update-subscribed-channels"]);
  }

  MySubscriptionsItem? get selectedChannelItemDetails =>
      _selectedChannelItemDetails.value;

  set selectedChannelItemDetails(MySubscriptionsItem? value) {
    _selectedChannelItemDetails.value = value;
    update(["update-selected-channel"]);
  }
}
