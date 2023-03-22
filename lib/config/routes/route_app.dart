import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:youtube/presentation/pages/home/logic/home_page_logic.dart';

/// currently, I don't use routes generator methods because there is a lot of run time errors.
/// I use normal Navigator because i don't know how to make Get.to without [appearNavigationBar].

class Go {
  final BuildContext context;
  final MiniVideoViewLogic videoController =
      Get.find<MiniVideoViewLogic>(tag: "1");
  Go(this.context);
  to(Widget page, {bool showFloatingVideo = true}) {
    final logic = Get.find<MiniVideoViewLogic>(tag: "1");
    final route = MaterialPageRoute(
        builder: (context) => page, maintainState: true);

    if (logic.moveThumbnailVideo) {
      logic.moveThumbnailVideo = false;
      return Navigator.of(context, rootNavigator: false)
          .push(route)
          .then((value) => logic.moveThumbnailVideo = true);
    }

    return Navigator.of(context, rootNavigator: false).push(route);
  }

  offAll(Widget page) => Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => page), (route) => false);

  offCurrent(Widget page, {bool materialRoute = false}) {
    return Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => page, maintainState: false));
  }

  back() => Navigator.of(context).maybePop();
}
