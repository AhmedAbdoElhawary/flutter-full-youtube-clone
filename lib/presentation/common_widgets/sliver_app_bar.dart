import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:youtube/config/routes/route_app.dart';
import 'package:youtube/core/resources/assets_manager.dart';
import 'package:youtube/core/resources/color_manager.dart';
import 'package:youtube/presentation/common_widgets/svg_icon.dart';

import '../pages/search/search_page.dart';

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
            children: [
              const RSizedBox(width: 20),
              const SvgIcon(IconsAssets.youtubeLogo, height: 20),
              const Spacer(),
              const SvgIcon(IconsAssets.broadcastIcon, height: 20),
              const RSizedBox(width: 20),
              const SvgIcon(IconsAssets.notificationIcon),
              const RSizedBox(width: 20),
              GestureDetector(
                  onTap: () {
                    Go<SearchPageParameters>(context).to(Routes.searchPage);
                  },
                  child: const Icon(Icons.search_rounded, size: 25)),
              const RSizedBox(width: 20),
              const CircleAvatar(
                  backgroundColor: ColorManager.teal, radius: 13),
              const RSizedBox(width: 20),
            ],
          ),
        ),
      ],
      bottom: preferredSizeWidget,
    );
  }
}
