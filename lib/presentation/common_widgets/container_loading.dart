
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:youtube/core/resources/color_manager.dart';

class ContainerLoading extends StatelessWidget {
  const ContainerLoading(
      {this.noPadding = false,
        this.color,
        this.width,
        this.height = 15,
        this.radius = 5,
        Key? key})
      : super(key: key);
  final double? width;
  final double height;
  final double radius;
  final Color? color;
  final bool noPadding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: REdgeInsets.all(noPadding ? 0 : 15.0),
      child: Container(
          height: height.h,
          width: width ?? double.infinity,
          decoration: BoxDecoration(
              color: color ?? ColorManager(context).grey1,
              borderRadius: BorderRadius.circular(radius.r))),
    );
  }
}
