import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:youtube/core/resources/assets_manager.dart';
import 'package:youtube/core/resources/color_manager.dart';
import 'package:youtube/presentation/common_widgets/search_icon.dart';
import 'package:youtube/presentation/common_widgets/svg_icon.dart';

class MainSliverAppBar extends StatelessWidget {
  const MainSliverAppBar({required this.preferredSizeWidget, Key? key})
      : super(key: key);
  final PreferredSizeWidget preferredSizeWidget;
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      floating: true,
      leading: const SizedBox(),
      leadingWidth: 0,
      titleSpacing: 0,
      actionsIconTheme: const IconThemeData(size: 20),
      backgroundColor: ColorManager(context).white,
      surfaceTintColor: ColorManager(context).white,
      actions: [
        Expanded(
          child: Row(
            children: const [
              RSizedBox(width: 20),
              SvgIcon(IconsAssets.youtubeLogo, height: 20),
              Spacer(),
              SvgIcon(IconsAssets.broadcastIcon, height: 20),
              RSizedBox(width: 20),
              SvgIcon(IconsAssets.notificationIcon),
              RSizedBox(width: 20),
              SearchIcon(),
              RSizedBox(width: 20),
              CircleAvatar(
                  backgroundColor: ColorManager.teal, radius: 13),
              RSizedBox(width: 20),
            ],
          ),
        ),
      ],
      bottom: preferredSizeWidget,
    );
  }
}
