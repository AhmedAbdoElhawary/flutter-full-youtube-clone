import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:youtube/core/resources/color_manager.dart';
import 'package:youtube/presentation/pages/home/logic/home_page_logic.dart';
import 'package:youtube/presentation/pages/home/views/home_page.dart';
import 'package:youtube/presentation/pages/library/library_page.dart';

import '../pages/subscriptions/subscriptions_page.dart';
import '../common_widgets/mini_player_video.dart';

class BaseLayout extends StatelessWidget {
  const BaseLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        backgroundColor: Theme.of(context).primaryColor,
        height: 44.h,
        border: Border(
            top: BorderSide(color: ColorManager(context).grey1, width: 1.w)),
        inactiveColor: ColorManager(context).black,
        activeColor: ColorManager(context).black,
        items: [
          navigationBarItem(Icons.home_outlined, Icons.home, "Home"),
          navigationBarItem(Icons.home_outlined, Icons.home, "Shorts"),
          navigationBarItem(Icons.add_circle_outline_outlined,
              Icons.add_circle_outlined, "Account"),
          navigationBarItem(Icons.subscriptions_outlined, Icons.subscriptions,
              "Subscriptions"),
          navigationBarItem(
              Icons.video_library_outlined, Icons.video_library, "Library"),
        ],
      ),
      tabBuilder: (context, index) {
        MiniVideoViewLogic miniVideoLogic =
            Get.put(MiniVideoViewLogic(), tag: "1");

        return Stack(
          children: [
            WhichPage(index),
            Obx(
              () {
                return miniVideoLogic.selectedVideoDetails != null
                    ? const MiniPlayerVideo()
                    : const SizedBox();
              },
            ),
          ],
        );
      },
    );
  }

  BottomNavigationBarItem navigationBarItem(
      IconData icon, IconData activeIcon, String label) {
    bool isThatAdd = label == "Account";
    return BottomNavigationBarItem(
        icon: Icon(icon, size: isThatAdd ? 40.r : 25.r),
        activeIcon: Icon(activeIcon, size: isThatAdd ? 40.r : 25.r),
        label: isThatAdd ? null : label);
  }
}

class WhichPage extends StatelessWidget {
  const WhichPage(this.index, {Key? key}) : super(key: key);
  final int index;
  @override
  Widget build(BuildContext context) {
    switch (index) {
      case 0:
        return const _HomePage();
      case 3:
        return const _SubscriptionsPage();
      default:
        return const _LibraryPage();
    }
  }
}

class _HomePage extends StatelessWidget {
  const _HomePage();

  @override
  Widget build(BuildContext context) {
    return CupertinoTabView(
      builder: (context) => const CupertinoPageScaffold(child: HomePage()),
    );
  }
}

class _SubscriptionsPage extends StatelessWidget {
  const _SubscriptionsPage();

  @override
  Widget build(BuildContext context) {
    return CupertinoTabView(
      builder: (context) =>
          const CupertinoPageScaffold(child: SubscriptionsPage()),
    );
  }
}

class _LibraryPage extends StatelessWidget {
  const _LibraryPage();

  @override
  Widget build(BuildContext context) {
    return CupertinoTabView(
      builder: (context) => const CupertinoPageScaffold(child: LibraryPage()),
    );
  }
}
