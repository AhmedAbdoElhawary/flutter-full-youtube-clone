import 'package:get/get.dart';
import 'package:youtube/presentation/pages/home/logic/home_page_logic.dart';
import 'package:youtube/presentation/pages/shorts/logic/shorts_page_logic.dart';

class BaseLayoutLogic extends GetxController {
  final RxBool _isShortsPageSelected = false.obs;
  final RxBool _isShortsInitialize = false.obs;
  final RxInt _selectedPage = 0.obs;

  tabControllerListener() {
    if (getSelectedPage != 0) {
      Get.find<MiniVideoViewLogic>(tag: "1").moveThumbnailVideo = false;
    }
    if (getSelectedPage == 1) {
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
  }

  int get getSelectedPage => _selectedPage.value;

  set setSelectedPage(int value) {
    _selectedPage.value = value;
    tabControllerListener();
    update(["update-selected-page"]);
  }

  bool get getShortsInitialize => _isShortsInitialize.value;

  set isShortsInitialize(bool value) => _isShortsInitialize.value = value;

  bool get isShortsPageSelected {
    return _isShortsPageSelected.value;
  }
}
