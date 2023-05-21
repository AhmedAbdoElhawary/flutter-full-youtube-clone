import 'package:flutter/material.dart';
import 'package:youtube/config/routes/route_app.dart';
import 'package:youtube/core/resources/assets_manager.dart';
import 'package:youtube/core/resources/color_manager.dart';
import 'package:youtube/presentation/common_widgets/svg_icon.dart';

class ArrowBack extends StatelessWidget {
  const ArrowBack(
      {this.makeItWhite = false,
      this.makeItSmall = false,
      this.onTapBack,
      Key? key})
      : super(key: key);
  final VoidCallback? onTapBack;
  final bool makeItWhite;
  final bool makeItSmall;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTapBack ??
          () {
            Go(context).back();
          },
      child: Padding(
        padding: const EdgeInsetsDirectional.only(top: 19, bottom: 19),
        child: SvgIcon(IconsAssets.arrowLeftIcon,
            color: makeItWhite ? BaseColorManager.white : null,
            size: makeItSmall ? 18 : 25),
      ),
    );
  }
}
