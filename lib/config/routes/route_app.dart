import 'package:flutter/cupertino.dart';
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
  to(Widget page, {bool appearNavigationBar = true, String? prevScreen}) {
    Get.find<MiniVideoViewLogic>(tag: "1").moveThumbnailVideo = false;
    return Navigator.of(context, rootNavigator: !appearNavigationBar)
        .push(
      CupertinoPageRoute(
          builder: (context) => page, maintainState: appearNavigationBar),
    )
        .then((value) {
      if (context.widget.toString() == "_MyChannelIconButton") {
        Get.find<MiniVideoViewLogic>(tag: "1").moveThumbnailVideo = true;
      }
    });
  }

  offAll(Widget page) => Navigator.of(context).pushAndRemoveUntil(
      CupertinoPageRoute(builder: (context) => page), (route) => false);

  offCurrent(Widget page, {bool materialRoute = false}) {
    return Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => page, maintainState: false));
  }

  back() => Navigator.of(context).maybePop();
}
