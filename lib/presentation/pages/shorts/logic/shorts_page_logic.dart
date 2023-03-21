import 'package:get/get.dart';

class ShortsLogic extends GetxController {
  final RxBool _stopVideo = false.obs;

  bool get stopVideo => _stopVideo.value;

  set stopVideo(bool value) {
    _stopVideo.value = value;
    update(["update-shorts-video"]);
  }
}
