import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:youtube/core/resources/color_manager.dart';
import 'package:youtube/presentation/views/home_page.dart';

class BaseLayout extends StatefulWidget {
  const BaseLayout({ Key? key}) : super(key: key);

  @override
  State<BaseLayout> createState() => _BaseLayoutState();
}

class _BaseLayoutState extends State<BaseLayout> {
  CupertinoTabController controller = CupertinoTabController();

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        backgroundColor: Theme.of(context).primaryColor,
        height: 44.h,
        border: Border(
            top: BorderSide(color: ColorManager(context).grey1, width: 1.5.w)),
        inactiveColor: ColorManager(context).black,
        activeColor: ColorManager(context).black,
        items: [
          navigationBarItem(Icons.home_outlined, "Home"),
          navigationBarItem(Icons.home_outlined, "Shorts"),
          navigationBarItem(Icons.person, "Account"),

          navigationBarItem(Icons.video_library_outlined, "Subscriptions"),
          navigationBarItem(Icons.video_library_outlined, "Library"),

        ],
      ),
      controller: controller,
      tabBuilder: (context, index) {
            return homePage();

      },
    );
  }

  Widget homePage() => CupertinoTabView(
        builder: (context) => const CupertinoPageScaffold(child: HomePage()),
      );
  BottomNavigationBarItem navigationBarItem(IconData icon, String label) {
    return BottomNavigationBarItem(icon: Icon(icon, size: 25.r), label: label);
  }
}
