import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:youtube/data/models/channel_details/channel_details.dart';
import 'package:youtube/presentation/pages/channel_profile/channel_profile_logic.dart';
import 'package:youtube/presentation/pages/channel_profile/tab_bar_views/about_view.dart';
import 'package:youtube/presentation/pages/channel_profile/tab_bar_views/playlists_view.dart';
import 'package:youtube/presentation/pages/channel_profile/tab_bar_views/shorts_view.dart';

import '../../../core/resources/color_manager.dart';
import '../../../core/resources/styles_manager.dart';
import 'tab_bar_views/home_view.dart';
import 'tab_bar_views/videos_view.dart';

class ProfilePage extends StatefulWidget {
  final bool isThatMyPersonalId;
  final Widget widgetsAboveBio;
  final ChannelDetailsItem? channelDetails;
  const ProfilePage(
      {required this.widgetsAboveBio,
      required this.isThatMyPersonalId,
      required this.channelDetails,
      Key? key})
      : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void dispose() {
    final logic = Get.find<ChannelProfileLogic>(tag: "1");
    logic.clearChannelCachedDetails(widget.channelDetails?.id ?? "");
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: DefaultTabController(
        length: 7,
        child: NestedScrollView(
          headerSliverBuilder: (_, __) {
            return [
              SliverList(
                delegate: SliverChildListDelegate([widget.widgetsAboveBio]),
              ),
            ];
          },
          body: Column(mainAxisSize: MainAxisSize.min, children: [
            const _TabBarIcons(),
            _TapBarView(widget.channelDetails)
          ]),
        ),
      ),
    );
  }
}

class _TapBarView extends StatelessWidget {
  const _TapBarView(this.channelDetails);
  final ChannelDetailsItem? channelDetails;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TabBarView(
        children: [
          TabBarHomeView(channelDetails),
          TabBarVideosView(channelDetails),
          TabBarShortVideosView(channelDetails),
          TabBarPlaylistView(channelDetails),
          const Center(child: Text("COMMUNITY")),
          const Center(child: Text("CHANNELS")),
          TabBarAboutView(channelDetails),
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
