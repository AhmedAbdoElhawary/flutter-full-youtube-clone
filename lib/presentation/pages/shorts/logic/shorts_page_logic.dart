import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:youtube/presentation/custom_packages/pod_player/src/controllers/pod_player_controller.dart';

class ShortsLogic extends GetxController {
  final RxBool _stopVideo = false.obs;
  late PodPlayerController videoController;
  final Rx<Widget> _videoStatusAnimation = Rx<Widget>(const SizedBox());

  @override
  void dispose() {
    videoController.dispose();
    super.dispose();
  }
  bool get stopVideo => _stopVideo.value;

  set stopVideo(bool value) {
    _stopVideo.value = value;
    if (!videoController.isInitialised) return;
    value ? videoController.pause() : videoController.play();
  }

  bool get isControllerInitialized => videoController.isInitialised;
  Widget get videoStatusAnimation => _videoStatusAnimation.value;

  set videoStatusAnimation(Widget value) {
    _videoStatusAnimation.value = value;
    update(["update current short"]);
  }
}
