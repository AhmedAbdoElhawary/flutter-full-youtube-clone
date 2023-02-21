import 'package:get/get.dart';

class ChannelProfileLogic extends GetxController {
  final RxBool _isRecentlyVideosSelected = true.obs;

  bool get getRecentlyVideosSelected => _isRecentlyVideosSelected.value;

  set isRecentlyVideosSelected(bool value) =>
      _isRecentlyVideosSelected.value = value;
}
