import 'package:get/get.dart';
import 'package:youtube/presentation/custom_packages/custom_tab_scaffold/custom_tab_scaffold.dart';
import 'package:youtube/presentation/pages/home/logic/home_page_logic.dart';
import 'package:youtube/presentation/pages/shorts/logic/shorts_page_logic.dart';

class BaseLayoutLogic extends GetxController {
  final tabController = CustomCupertinoTabController();
  final RxBool _isShortsPageSelected = false.obs;
  final RxBool _isShortsInitialize = false.obs;
  @override
  void onInit() {
    tabControllerListener();
    super.onInit();
  }

  tabControllerListener() {
    tabController.addListener(
      () {
        int selectedPage = tabController.index;
        if (selectedPage != 0) {
          Get.find<MiniVideoViewLogic>(tag: "1").moveThumbnailVideo = false;
        }
        if (selectedPage == 1) {
          _isShortsPageSelected.value = true;

          final logic =
              Get.find<MiniVideoViewLogic>(tag: "1").floatingVideoController;
          if (logic != null) logic.pause();

          if (getShortsInitialize) {
            final shortsLogic = Get.find<ShortsLogic>(tag: "1");
            shortsLogic.stopVideo = false;
          }
        } else if (isShortsPageSelected) {
          _isShortsPageSelected.value = false;
          if (getShortsInitialize) {
            final shortsLogic = Get.find<ShortsLogic>(tag: "1");

            shortsLogic.stopVideo = true;
          }
        }
      },
    );
  }

  bool get getShortsInitialize => _isShortsInitialize.value;

  set isShortsInitialize(bool value) => _isShortsInitialize.value = value;

  bool get isShortsPageSelected {
    return _isShortsPageSelected.value;
  }
}
