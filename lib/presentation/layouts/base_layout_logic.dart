import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:youtube/presentation/pages/home/logic/home_page_logic.dart';
import 'package:youtube/presentation/pages/home/views/home_page.dart';
import 'package:youtube/presentation/pages/library/library_page.dart';
import 'package:youtube/presentation/pages/shorts/logic/shorts_page_logic.dart';
import 'package:youtube/presentation/pages/shorts/shorts_page.dart';
import 'package:youtube/presentation/pages/subscriptions/subscriptions_page.dart';

class BaseLayoutLogic extends GetxController {
  final RxBool _isShortsPageSelected = false.obs;
  final RxBool _isShortsInitialize = false.obs;
  final RxInt _selectedPage = 0.obs;
  static late final TabController tabController;
  final Map<String, List<Widget>> _pagesRoutesPool = {
    "home": [const HomePage()],
    "short": [const ShortsPage()],
    "subscription": [const SubscriptionsPage()],
    "library": [const LibraryPage()],
  };



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

  set setSelectedTapPage(int value) {
    _selectedPage.value = value;
    tabControllerListener();
    update(["update-selected-page"]);
  }

  set setIsShortsPageSelected(bool value) {
    _isShortsPageSelected.value = value;
    update(["update-selected-page"]);
  }
  //
  // Map<String, List<String>> get getLastHomeRoute => _pagesRoutesPool;
  //
  // set pagesRoutesPool(Map<String, List<String>> value) {
  //   _pagesRoutesPool = value;
  // }

  bool get getShortsInitialize => _isShortsInitialize.value;

  set isShortsInitialize(bool value) => _isShortsInitialize.value = value;

  bool get isShortsPageSelected => _isShortsPageSelected.value;
}
