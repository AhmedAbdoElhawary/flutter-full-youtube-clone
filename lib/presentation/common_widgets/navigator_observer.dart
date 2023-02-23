part of '../my_app.dart';

class MyNavigatorObserver extends NavigatorObserver {
  BaseLayoutLogic baseLayoutLogic = Get.find<BaseLayoutLogic>(tag: "1");
  ShortsLogic shortsLogic = Get.find<ShortsLogic>(tag: "1");

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    if (baseLayoutLogic.isShortsPageSelected) shortsLogic.stopVideo = true;
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    if (baseLayoutLogic.isShortsPageSelected) shortsLogic.stopVideo = false;
  }
}
