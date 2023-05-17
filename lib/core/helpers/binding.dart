import 'package:get/get.dart';
import 'package:youtube/presentation/layouts/base_layout_logic.dart';
import 'package:youtube/presentation/pages/channel_profile/channel_profile_logic.dart';
import 'package:youtube/presentation/pages/home/logic/home_page_logic.dart';
import 'package:youtube/presentation/pages/shorts/logic/shorts_page_logic.dart';
import 'package:youtube/presentation/pages/subscriptions/logic/subscriptions_page_logic.dart';

class GetXBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(BaseLayoutLogic(), tag: "1");
    Get.put(SubscriptionsPageLogic(), tag: "1");
    Get.put(ShortsLogic(), tag: "1");
    Get.put(MiniVideoViewLogic(), tag: "1");
    Get.lazyPut(() => ChannelProfileLogic(), tag: "1", fenix: true);
  }
}
