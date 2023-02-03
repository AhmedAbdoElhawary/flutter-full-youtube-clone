import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:youtube/core/resources/color_manager.dart';

class CustomAppBar {
  final BuildContext context;
  CustomAppBar(this.context);

  static AppBar mainAppBar() {
    return AppBar(
      leading: const Icon(Icons.yard_outlined, size: 40),
      actionsIconTheme: IconThemeData(size: 20),
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
    );
  }
}
