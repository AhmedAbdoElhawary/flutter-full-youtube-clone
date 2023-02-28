import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:youtube/core/resources/color_manager.dart';
import 'package:youtube/core/resources/styles_manager.dart';
import 'package:youtube/presentation/common_widgets/mini_player_video/mini_player_video.dart';
import 'package:youtube/presentation/layouts/base_layout_logic.dart';
import 'package:youtube/presentation/pages/home/logic/home_page_logic.dart';
import 'package:youtube/presentation/pages/home/views/home_page.dart';
import 'package:youtube/presentation/pages/library/library_page.dart';
import 'package:youtube/presentation/pages/shorts/shorts_page.dart';
import 'package:youtube/presentation/pages/subscriptions/subscriptions_page.dart';

class BaseLayout extends StatefulWidget {
  const BaseLayout({super.key});

  @override
  BaseLayoutState createState() => BaseLayoutState();
}

class BaseLayoutState extends State<BaseLayout>
    with SingleTickerProviderStateMixin {
  int _selectedIndex = 0;
  Color iconLabelColor = BaseColorManager.black;
  final baseLayoutLogic = Get.find<BaseLayoutLogic>(tag: "1");
  final miniVideoLogic = Get.find<MiniVideoViewLogic>(tag: "1");
  final PageStorageBucket bucket = PageStorageBucket();

  final List<Widget> _pages = [
    const HomePage(),
    const ShortsPage(),
    const LibraryPage(),
    const SubscriptionsPage(),
    const LibraryPage(),
  ];

  @override
  void initState() {
    super.initState();

    miniVideoLogic.navigationTabController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300), value: 1);
  }

  void _onItemTapped(int index, BuildContext context) {
    setState(() {
      _selectedIndex = index;
      baseLayoutLogic.changeSelectedPage = index;
      iconLabelColor = _selectedIndex == 1
          ? BaseColorManager.white
          : Theme.of(context).focusColor;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBarTheme(
      data: BottomNavigationBarThemeData(
        backgroundColor: _selectedIndex == 1
            ? BaseColorManager.black
            : Theme.of(context).primaryColor,
        selectedItemColor: iconLabelColor,
        unselectedItemColor: iconLabelColor,
        selectedLabelStyle: getNormalStyle(color: iconLabelColor, fontSize: 11),
        unselectedLabelStyle:
            getNormalStyle(color: iconLabelColor, fontSize: 11),
      ),
      child: Scaffold(
        body: Stack(
          children: [
            PageStorage(bucket: bucket, child: _pages[_selectedIndex]),
            Obx(() => miniVideoLogic.selectedVideoDetails == null
                ? const SizedBox()
                : const MiniPlayerVideo()),
          ],
        ),
        bottomNavigationBar: _bottomSheet(context),
      ),
    );
  }

  Container _bottomSheet(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
            top: BorderSide(
                color: _selectedIndex == 1
                    ? ColorManager(context).grey9
                    : ColorManager(context).grey1,
                width: 1.w)),
      ),
      child: Obx(
        () => SizeTransition(
          sizeFactor: miniVideoLogic.navigationTabController,
          child: BottomNavigationBar(
            currentIndex: _selectedIndex,
            type: BottomNavigationBarType.fixed,
            onTap: (value) => _onItemTapped(value, context),
            items: [
              navigationBarItem(Icons.home_outlined, Icons.home, "Home"),
              navigationBarItem(Icons.home_outlined, Icons.home, "Shorts"),
              navigationBarItem(Icons.add_circle_outline_outlined,
                  Icons.add_circle_outlined, "Account"),
              navigationBarItem(Icons.subscriptions_outlined,
                  Icons.subscriptions, "Subscriptions"),
              navigationBarItem(
                  Icons.video_library_outlined, Icons.video_library, "Library"),
            ],
          ),
        ),
      ),
    );
  }

  BottomNavigationBarItem navigationBarItem(
      IconData icon, IconData activeIcon, String label) {
    bool isThatAdd = label == "Account";
    return BottomNavigationBarItem(
        icon: Icon(icon, size: isThatAdd ? 40.r : 25.r),
        activeIcon: Icon(activeIcon, size: isThatAdd ? 40.r : 25.r),
        label: isThatAdd ? "" : label);
  }
}
