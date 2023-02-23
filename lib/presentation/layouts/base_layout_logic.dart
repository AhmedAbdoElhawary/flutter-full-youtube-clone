import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:youtube/presentation/pages/shorts/logic/shorts_page_logic.dart';

class BaseLayoutLogic extends GetxController {
  final tabController = CupertinoTabController();
  final RxBool _isShortsPageSelected = false.obs;
  final _shortsLogic = Get.find<ShortsLogic>(tag: "1");

  @override
  void onInit() {
    tabControllerListener();
    super.onInit();
  }

  tabControllerListener() {
    tabController.addListener(() {
      int selectedPage = tabController.index;
      if (selectedPage == 1) {
        _isShortsPageSelected.value = true;
        _shortsLogic.stopVideo = false;

      } else if (isShortsPageSelected) {
        _shortsLogic.stopVideo = true;
        _isShortsPageSelected.value = false;
      }
    });
  }

  bool get isShortsPageSelected => _isShortsPageSelected.value;
}
