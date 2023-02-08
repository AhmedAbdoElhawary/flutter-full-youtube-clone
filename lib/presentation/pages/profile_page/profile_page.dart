import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/resources/color_manager.dart';
import '../../../core/resources/styles_manager.dart';
import 'tab_bar_views/home_view.dart';
import 'tab_bar_views/videos_view.dart';

class ProfilePage extends StatelessWidget {
  final bool isThatMyPersonalId;
  final Widget widgetsAboveBio;

  const ProfilePage(
      {required this.widgetsAboveBio,
      required this.isThatMyPersonalId,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: DefaultTabController(
        length: 7,
        child: NestedScrollView(
          headerSliverBuilder: (_, __) {
            return [
              SliverList(
                delegate: SliverChildListDelegate([widgetsAboveBio]),
              ),
            ];
          },
          body: Column(
              mainAxisSize: MainAxisSize.min,
              children: const [_TabBarIcons(), _TapBarView()]),
        ),
      ),
    );
  }
}

class _TapBarView extends StatelessWidget {
  const _TapBarView();

  @override
  Widget build(BuildContext context) {
    return const Expanded(
      child: TabBarView(
        children: [
          TabBarHomeView(),
          TabBarVideosView(),
          Center(child: Text("SHORTS")),
          Center(child: Text("PLAYLISTS")),
          Center(child: Text("COMMUNITY")),
          Center(child: Text("CHANNELS")),
          Center(child: Text("ABOUT")),
        ],
      ),
    );
  }
}

class _TabBarIcons extends StatelessWidget {
  const _TabBarIcons();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border:
              Border(bottom: BorderSide(color: ColorManager(context).grey2))),
      child: TabBar(
        unselectedLabelColor: ColorManager(context).grey7,
        labelColor: Theme.of(context).focusColor,
        indicatorSize: TabBarIndicatorSize.tab,
        isScrollable: true,
        labelPadding: REdgeInsets.symmetric(horizontal: 20),
        indicator:
            const BoxDecoration(border: Border(bottom: BorderSide(width: 2))),
        labelStyle:
            getMediumStyle(fontSize: 14, color: ColorManager(context).black),
        tabs: const [
          Tab(child: Text("HOME")),
          Tab(child: Text("VIDEOS")),
          Tab(child: Text("SHORTS")),
          Tab(child: Text("PLAYLISTS")),
          Tab(child: Text("COMMUNITY")),
          Tab(child: Text("CHANNELS")),
          Tab(child: Text("ABOUT")),
        ],
      ),
    );
  }
}
