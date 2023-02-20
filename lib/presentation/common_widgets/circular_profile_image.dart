import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:youtube/config/routes/route_app.dart';
import 'package:youtube/data/models/channel_details/channel_details.dart';

import '../../core/resources/color_manager.dart';
import '../pages/channel_profile/user_profile_page.dart';

class CircularProfileImage extends StatelessWidget {
  final bool enableTapping;
  final double radius;
  final String imageUrl;
  final String channelId;
  final ChannelDetailsItem? channelDetailsItem;
  const CircularProfileImage(
      {this.imageUrl = "",
      this.channelDetailsItem,
      this.enableTapping = true,
      this.radius = 18,
      this.channelId = "",
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (!enableTapping || channelId.isEmpty) return;

        Go(context).to(
          UserProfilePage(
            channelDetailsItem: channelDetailsItem,
            channelId: channelId,
          ),
        );
      },
      child: CircleAvatar(
        radius: radius.r,
        backgroundColor: ColorManager(context).grey,
        backgroundImage: imageUrl.isNotEmpty ? NetworkImage(imageUrl) : null,
      ),
    );
  }
}
