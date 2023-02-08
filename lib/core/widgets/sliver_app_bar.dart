import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:youtube/core/resources/color_manager.dart';

class MainSliverAppBar extends StatelessWidget {
  const MainSliverAppBar({required this.preferredSizeWidget, Key? key})
      : super(key: key);
  final PreferredSizeWidget preferredSizeWidget;
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      floating: true,
      leading: const Icon(Icons.yard_outlined, size: 40),
      actionsIconTheme: const IconThemeData(size: 20),
      backgroundColor: ColorManager(context).white,
      surfaceTintColor: ColorManager(context).white,
      actions: const [
        Icon(Icons.search_rounded, size: 25),
        RSizedBox(width: 20),
        Icon(Icons.search_rounded, size: 25),
        RSizedBox(width: 20),
        Icon(Icons.search_rounded, size: 25),
        RSizedBox(width: 20),
        CircleAvatar(backgroundColor: ColorManager.teal, radius: 13),
        RSizedBox(width: 20),
      ],
      bottom: preferredSizeWidget,
    );
  }
}
