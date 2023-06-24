import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:youtube/config/themes/theme_service.dart';
import 'package:youtube/core/resources/assets_manager.dart';
import 'package:youtube/core/resources/color_manager.dart';
import 'package:youtube/core/utility/constants.dart';
import 'package:youtube/presentation/common_widgets/mini_player_video/mini_player_video.dart';
import 'package:youtube/presentation/common_widgets/svg_icon.dart';
import 'package:youtube/presentation/custom_packages/custom_tab_scaffold/custom_bottom_tab_bar.dart';
import 'package:youtube/presentation/layouts/base_layout_logic.dart';
import 'package:youtube/presentation/pages/home/logic/home_page_logic.dart';

class MainTabBar extends StatefulWidget {
  const MainTabBar({super.key});

  @override
  State<MainTabBar> createState() => _MainTabBarState();
}

class _MainTabBarState extends State<MainTabBar>{

  @override
  Widget build(BuildContext context) {
    screenSize = MediaQuery.of(context).size;

    final baseLayoutLogic = Get.find<BaseLayoutLogic>(tag: "1");
    final miniVideoLogic = Get.put(MiniVideoViewLogic(), tag: "1");

    return Obx(
          () {
        bool isThemeDark = ThemeOfApp().isThemeDark();

        bool isShortsPageSelected =
            baseLayoutLogic.isShortsPageSelected && !isThemeDark;

        Color? color = isShortsPageSelected ? BaseColorManager.white : null;

        return Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            const Flexible(child: _FloatingVideo()),

            CustomCupertinoTabBar(
              onTap: (int page) {
                BaseLayoutLogic.tabController.animateTo(page,
                    duration: const Duration(microseconds: 300),
                    curve: Curves.easeInOut);
              },
              backgroundColor: isShortsPageSelected && !isThemeDark
                  ? Theme.of(context).focusColor
                  : Theme.of(context).primaryColor,
              height: miniVideoLogic.heightOfNavigationBar.value.h,
              border: Border(
                  top: BorderSide(
                      color: isShortsPageSelected
                          ? ColorManager(context).grey9
                          : ColorManager(context).grey1,
                      width: 1.w)),
              inactiveColor: isShortsPageSelected
                  ? ColorManager(context).white
                  : ColorManager(context).black,
              activeColor: isShortsPageSelected
                  ? ColorManager(context).white
                  : ColorManager(context).black,
              items: [
                BottomNavigationBarItem(
                    icon: SvgIcon(IconsAssets.homeIcon, size: 25, color: color),
                    activeIcon:
                    const SvgIcon(IconsAssets.homeColoredIcon, size: 25),
                    label: "Home"),
                BottomNavigationBarItem(
                    icon: SvgIcon(IconsAssets.shortsIcon, size: 25, color: color),
                    activeIcon:
                    SvgIcon(IconsAssets.shortsIcon, size: 25, color: color),
                    label: "Shorts"),
                BottomNavigationBarItem(
                  icon: SvgIcon(IconsAssets.addIcon, size: 35, color: color),
                  activeIcon: const SvgIcon(IconsAssets.addIcon, size: 35),
                ),
                BottomNavigationBarItem(
                    icon: SvgIcon(IconsAssets.subscriptionIcon,
                        size: 25, color: color),
                    activeIcon: const SvgIcon(IconsAssets.subscriptionColoredIcon,
                        size: 25),
                    label: "Subscriptions"),
                BottomNavigationBarItem(
                    icon:
                    SvgIcon(IconsAssets.libraryIcon, size: 25, color: color),
                    activeIcon:
                    const SvgIcon(IconsAssets.libraryColoredIcon, size: 25),
                    label: "Library"),
              ],
            ),
          ],
        );
      },
    );
  }

  SystemUiOverlayStyle overlayStyle(BuildContext context, bool isThemeDark) {
    return SystemUiOverlayStyle(
        statusBarColor: ColorManager(context).white,
        statusBarIconBrightness:
        isThemeDark ? Brightness.light : Brightness.dark,
        systemNavigationBarDividerColor: ColorManager(context).white,
        systemNavigationBarColor: ColorManager(context).white,
        statusBarBrightness: isThemeDark ? Brightness.dark : Brightness.light,
        systemNavigationBarIconBrightness: Brightness.light);
  }

  BottomNavigationBarItem navigationBarItem(
      String icon, String activeIcon, String label) {
    bool isThatAdd = label == "Account";
    return BottomNavigationBarItem(
        icon: SvgIcon(icon, size: isThatAdd ? 40.r : 25.r),
        activeIcon: SvgIcon(activeIcon, size: isThatAdd ? 40.r : 25.r),
        label: isThatAdd ? null : label);
  }
}


class _FloatingVideo extends StatefulWidget {
  const _FloatingVideo();

  @override
  State<_FloatingVideo> createState() => _FloatingVideoState();
}

class _FloatingVideoState extends State<_FloatingVideo> {
  @override
  Widget build(BuildContext context) {

    return GetBuilder<MiniVideoViewLogic>(
      tag: "1",
      id: "update-base-selected-video",
      builder: (controller) {
        Widget floatingVideo = !controller.showFloatingVideo ||
            controller.getSelectedVideoDetails == null
            ? const SizedBox()
            : const MiniPlayerVideo();

        return floatingVideo;
      },
    );
  }
}
