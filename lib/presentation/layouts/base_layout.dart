import 'package:flutter/material.dart';
import 'package:youtube/presentation/layouts/base_layout_logic.dart';
import 'package:youtube/presentation/layouts/main_tab_bar.dart';
import 'package:youtube/presentation/pages/home/views/home_page.dart';
import 'package:youtube/presentation/pages/library/library_page.dart';
import 'package:youtube/presentation/pages/shorts/shorts_page.dart';

import '../pages/subscriptions/subscriptions_page.dart';

class BaseLayout extends StatefulWidget {
  final Widget? child;
  const BaseLayout._internal({this.child});
  factory BaseLayout({Widget? child}) => BaseLayout._internal(child: child);

  @override
  State<BaseLayout> createState() => _BaseLayoutState();
}

class _BaseLayoutState extends State<BaseLayout>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    if (widget.child == null) {
      BaseLayoutLogic.tabController = TabController(length: 4, vsync: this);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        widget.child ??
            TabBarView(
              controller: BaseLayoutLogic.tabController,
              physics: const NeverScrollableScrollPhysics(),
              children: const [
                HomePage(),
                ShortsPage(),
                SubscriptionsPage(),
                LibraryPage(),
              ],
            ),
        const Align(alignment: Alignment.bottomCenter, child: MainTabBar()),
      ],
    );
  }
}
