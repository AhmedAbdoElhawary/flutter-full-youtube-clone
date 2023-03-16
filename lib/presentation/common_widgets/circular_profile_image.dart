import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:youtube/config/routes/route_app.dart';
import 'package:youtube/data/models/channel_details/channel_details.dart';
import 'package:youtube/presentation/layouts/base_layout_logic.dart';
import 'package:youtube/presentation/pages/home/logic/home_page_logic.dart';

import '../../core/resources/color_manager.dart';
import '../pages/channel_profile/user_channel_page.dart';

class CircularProfileImage extends StatefulWidget {
  final bool enableTapping;
  final double radius;
  final String imageUrl;
  final String channelId;
  final ChannelDetailsItem? channelDetailsItem;
  final bool isThatFloatingPlayer;

  const CircularProfileImage(
      {this.imageUrl = "",
      this.channelDetailsItem,
      this.enableTapping = true,
      this.isThatFloatingPlayer = false,
      this.radius = 18,
      this.channelId = "",
      Key? key})
      : super(key: key);

  @override
  State<CircularProfileImage> createState() => _CircularProfileImageState();
}

class _CircularProfileImageState extends State<CircularProfileImage> {
  void cacheImage() {
    if (widget.imageUrl.isNotEmpty) {
      precacheImage(NetworkImage(widget.imageUrl), context);
    }
  }

  @override
  void didChangeDependencies() {
    cacheImage();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (!widget.enableTapping || widget.channelId.isEmpty) return;

        Get.find<MiniVideoViewLogic>(tag: "1")
            .stateOfMiniPlayer(extendHeight: false);

        int selectedIndex =
            Get.find<BaseLayoutLogic>(tag: "1").tabController.index;

        Go(context).to(
          UserChannelPage(
            key: selectedIndex == 0 ? const Key("from-home-page") : null,
            UserChannelPageParameters(
              channelDetailsItem: widget.channelDetailsItem,
              channelId: widget.channelId,
            ),
          ),
        );
      },
      child: CircleAvatar(
        radius: widget.radius.r,
        backgroundColor: ColorManager(context).grey,
        backgroundImage: widget.imageUrl.isNotEmpty
            ? CachedNetworkImageProvider(widget.imageUrl)
            : null,
      ),
    );
  }
}
