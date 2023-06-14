import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:youtube/core/resources/assets_manager.dart';
import 'package:youtube/core/resources/color_manager.dart';
import 'package:youtube/core/resources/styles_manager.dart';
import 'package:youtube/presentation/common_widgets/arrow_back.dart';
import 'package:youtube/presentation/common_widgets/search_icon.dart';
import 'package:youtube/presentation/common_widgets/svg_icon.dart';

class CustomAppBar {
  final BuildContext context;
  CustomAppBar(this.context);

  AppBar normalAppBar(String title,
      {bool withoutIcons = false, VoidCallback? onTabBack}) {
    return AppBar(
      leading: ArrowBack(onTapBack: onTabBack),
      backgroundColor: ColorManager(context).white,
      title: Text(
        title,
        style: getMediumStyle(color: ColorManager(context).black, fontSize: 20),
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
      ),
      actions: withoutIcons
          ? null
          : const [
              RSizedBox(width: 20),
              SearchIcon(),
              RSizedBox(width: 20),
              SvgIcon(IconsAssets.menuPointsVerticalIcon, size: 15),
              RSizedBox(width: 20),
            ],
    );
  }
}
