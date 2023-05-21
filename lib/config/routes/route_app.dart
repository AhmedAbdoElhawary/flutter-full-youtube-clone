import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:youtube/presentation/layouts/base_layout.dart';
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
    final route =
        MaterialPageRoute(builder: (context) => BaseLayout(widget: page));

    if (logic.moveThumbnailVideo) {
      logic.moveThumbnailVideo = false;
      return Navigator.of(context)
          .push(route)
          .then((value) => logic.moveThumbnailVideo = true);
    }

    return Navigator.of(context).push(route);
  }

  offAll(Widget page) => Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => page), (route) => false);

  offCurrent(Widget page) {
    return Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => BaseLayout(widget: page)));
  }

  back() => Navigator.of(context).maybePop();
}
