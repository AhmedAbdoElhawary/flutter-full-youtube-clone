import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SvgIcon extends StatelessWidget {
  const SvgIcon(this.assetName, {this.height = 25, this.color, Key? key})
      : super(key: key);
  final String assetName;
  final double height;
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      assetName,
      height: height.r,
      colorFilter:
          color != null ? ColorFilter.mode(color!, BlendMode.srcIn) : null,
    );
  }
}
