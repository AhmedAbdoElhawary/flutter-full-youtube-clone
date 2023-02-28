import 'package:get/get.dart';
import 'package:youtube/presentation/pages/shorts/logic/shorts_page_logic.dart';

class BaseLayoutLogic extends GetxController {
  final RxBool _isShortsPageSelected = false.obs;
  final RxInt _selectedPage = 0.obs;
  final _shortsLogic = Get.find<ShortsLogic>(tag: "1");
  final RxBool _isShortsInitialize = false.obs;

  int get selectedPage => _selectedPage.value;

  set changeSelectedPage(int index) {
    _selectedPage.value = index;
    if (selectedPage == 1) {
      _isShortsPageSelected.value = true;
      if (isShortsInitialize) _shortsLogic.stopVideo = false;
    } else if (isShortsPageSelected) {
      _isShortsPageSelected.value = false;
      if (isShortsInitialize) _shortsLogic.stopVideo = true;
    }
  }

  bool get isShortsInitialize => _isShortsInitialize.value;

  set isShortsInitialize(bool value) => _isShortsInitialize.value = value;

  bool get isShortsPageSelected => _isShortsPageSelected.value;
}
