import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:video_player/video_player.dart';

class ShortsLogic extends GetxController {
  final RxBool _stopVideo = false.obs;
  late VideoPlayerController controller;
  late Future<void> initializeVideoPlayerFuture;
  final Rx<Widget> _videoStatusAnimation = Rx<Widget>(const SizedBox());

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
  bool get stopVideo => _stopVideo.value;

  set stopVideo(bool value) {
    _stopVideo.value = value;
    if (!controller.value.isInitialized) return;
    value ? controller.pause() : controller.play();
  }

  bool get isControllerInitialized => controller.value.isInitialized;
  Widget get videoStatusAnimation => _videoStatusAnimation.value;

  set videoStatusAnimation(Widget value) {
    _videoStatusAnimation.value = value;
    update(["update current short"]);
  }
}
