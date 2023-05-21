import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:youtube/core/resources/assets_manager.dart';
import 'package:youtube/core/resources/color_manager.dart';
import 'package:youtube/core/utility/constants.dart';
import 'package:youtube/presentation/common_widgets/mini_player_video/mini_player_video.dart';
import 'package:youtube/presentation/common_widgets/svg_icon.dart';
import 'package:youtube/presentation/custom_packages/custom_tab_scaffold/custom_bottom_tab_bar.dart';
import 'package:get/get.dart';
import 'package:youtube/config/themes/theme_service.dart';
import 'package:youtube/presentation/layouts/base_layout_logic.dart';
import 'package:youtube/presentation/pages/home/logic/home_page_logic.dart';
import 'package:youtube/presentation/pages/home/views/home_page.dart';
import 'package:youtube/presentation/pages/library/library_page.dart';
import 'package:youtube/presentation/pages/shorts/shorts_page.dart';
import '../pages/subscriptions/subscriptions_page.dart';

class BaseLayout extends StatelessWidget {
  const BaseLayout._internal({this.widget});
  final Widget? widget;

  static BaseLayout? _instance;
  static BaseLayout get instance => _instance!;

  factory BaseLayout({Widget? widget}) => BaseLayout._internal(widget: widget);

  @override
  Widget build(BuildContext context) {
    screenSize = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          GetBuilder<BaseLayoutLogic>(
            tag: "1",
            id: "update-selected-page",
            builder: (controller) {
              return Column(
                children: [
                  Flexible(
                    child: widget != null
                        ? widget!
                        : WhichPage(controller.getSelectedPage),
                  ),
                  const SizedBox(
                    height: highOfBottomNavigationBar,
                    width: double.infinity,
                  ),
                ],
              );
            },
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              GetBuilder<BaseLayoutLogic>(
                tag: "1",
                id: "update-selected-page",
                builder: (controller) {
                  return controller.getSelectedPage != 1 &&
                          widget is! ShortsPage
                      ? Flexible(flex: 1, child: FloatingPlayer())
                      : const SizedBox();
                },
              ),
              const BottomNavigationBar(),
            ],
          ),
        ],
      ),
    );
  }
}

class FloatingPlayer extends StatefulWidget {
  const FloatingPlayer._internal();

  static BaseLayout? _instance;
  static BaseLayout get instance => _instance!;

  factory FloatingPlayer() => const FloatingPlayer._internal();

  @override
  State<FloatingPlayer> createState() => _FloatingPlayerState();
}

class _FloatingPlayerState extends State<FloatingPlayer> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<MiniVideoViewLogic>(
      tag: "1",
      id: "update-base-selected-video",
      builder: (controller) => !controller.showFloatingVideo ||
              controller.getSelectedVideoDetails == null
          ? const SizedBox()
          : const MiniPlayerVideo(),
    );
  }
}

class WhichPage extends StatelessWidget {
  const WhichPage(this.index, {Key? key}) : super(key: key);
  final int index;
  @override
  Widget build(BuildContext context) {
    switch (index) {
      case 0:
        return const HomePage();
      case 1:
        return const ShortsPage();
      case 3:
        return const SubscriptionsPage();
      default:
        return const LibraryPage();
    }
  }
}

class BottomNavigationBar extends StatelessWidget {
  const BottomNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final baseLayoutLogic = Get.find<BaseLayoutLogic>(tag: "1");
      final miniVideoLogic = Get.find<MiniVideoViewLogic>(tag: "1");

      bool isThemeDark = ThemeOfApp().isThemeDark();

      bool isShortsPageSelected =
          baseLayoutLogic.isShortsPageSelected && !isThemeDark;

      bool makeThemeDark = baseLayoutLogic.isShortsPageSelected || isThemeDark;

      Color? color = isShortsPageSelected ? BaseColorManager.white : null;

      return AnnotatedRegion<SystemUiOverlayStyle>(
        value: systemUiOverlayStyle(context, makeThemeDark),
        child: CustomCupertinoTabBar(
          onTap: (int pageIndex) {
            baseLayoutLogic.setSelectedTapPage = pageIndex;
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
                label: "Home"),
            BottomNavigationBarItem(
                icon: SvgIcon(IconsAssets.shortsIcon, size: 25, color: color),
                label: "Shorts"),
            BottomNavigationBarItem(
              icon: SvgIcon(IconsAssets.addIcon, size: 35, color: color),
            ),
            BottomNavigationBarItem(
                icon: SvgIcon(IconsAssets.subscriptionIcon,
                    size: 25, color: color),
                label: "Subscriptions"),
            BottomNavigationBarItem(
                icon: SvgIcon(IconsAssets.libraryIcon, size: 25, color: color),
                label: "Library"),
          ],
        ),
      );
    });
  }

  SystemUiOverlayStyle systemUiOverlayStyle(
      BuildContext context, bool isThemeDark) {
    Color color = isThemeDark ? BaseColorManager.black : BaseColorManager.white;

    return SystemUiOverlayStyle(
        statusBarColor: color,
        statusBarIconBrightness:
            isThemeDark ? Brightness.light : Brightness.dark,
        systemNavigationBarDividerColor: color,
        systemNavigationBarColor: color,
        statusBarBrightness: isThemeDark ? Brightness.dark : Brightness.light,
        systemNavigationBarIconBrightness: Brightness.light);
  }
}
