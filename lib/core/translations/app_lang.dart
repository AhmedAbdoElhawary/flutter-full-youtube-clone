import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:youtube/core/translations/local_storage/local_storage.dart';
import 'package:youtube/presentation/custom_packages/custom_mini_player/mini_player_logic.dart';
import 'package:youtube/presentation/layouts/base_layout_logic.dart';
import 'package:youtube/presentation/pages/home/logic/home_page_logic.dart';
import 'package:youtube/presentation/pages/shorts/logic/shorts_page_logic.dart';

class AppLanguage extends GetxController {
  String _appLocale = 'en';

  @override
  void onInit() async {
    super.onInit();
    LocalStorage localStorage = LocalStorage();
    Get.put(MiniVideoViewLogic(), tag: "1");
    Get.put(ShortsLogic(), tag: "1");
    Get.put(MiniPlayerLogic(), tag: "1");
    Get.put(BaseLayoutLogic(), tag: "1");

    _appLocale = await localStorage.languageSelected ?? 'en';
    update();
    Get.updateLocale(Locale(_appLocale));
  }

  String get appLang => _appLocale;

  void changeLanguage() async {
    LocalStorage localStorage = LocalStorage();

    if (_appLocale == 'en') {
      _appLocale = 'ar';
      localStorage.saveLanguageToDisk('ar');
    } else {
      _appLocale = 'en';
      localStorage.saveLanguageToDisk('en');
    }
    update();
  }
}
