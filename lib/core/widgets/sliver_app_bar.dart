import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:youtube/config/routes/route_app.dart';
import 'package:youtube/core/resources/color_manager.dart';

import '../../presentation/pages/search/search_page.dart';

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
      actions: [
        GestureDetector(
            onTap: () {
              Go(context).to(const SearchPage());
            },
            child: const Icon(Icons.search_rounded, size: 25)),
        const RSizedBox(width: 20),
        const Icon(Icons.search_rounded, size: 25),
        const RSizedBox(width: 20),
        const Icon(Icons.search_rounded, size: 25),
        const RSizedBox(width: 20),
        const CircleAvatar(backgroundColor: ColorManager.teal, radius: 13),
        const RSizedBox(width: 20),
      ],
      bottom: preferredSizeWidget,
    );
  }
}