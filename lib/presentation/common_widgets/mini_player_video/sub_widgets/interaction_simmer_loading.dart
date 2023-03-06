import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:youtube/core/resources/color_manager.dart';

class InteractionShimmerLoading extends StatelessWidget {
  const InteractionShimmerLoading(
      {this.width = 130, this.withoutPadding = false, super.key});
  final double width;
  final bool withoutPadding;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: REdgeInsetsDirectional.only(
          start: withoutPadding ? 0 : 15, top: withoutPadding ? 0 : 15),
      child:Container(
        width: width.w,
        height: 30.h,
        decoration: BoxDecoration(
            color: ColorManager(context).grey1,
            borderRadius: BorderRadius.circular(20.r)),
      ),
    );
  }
}
