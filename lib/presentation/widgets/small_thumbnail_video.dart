
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/resources/color_manager.dart';

class ThumbnailVideo extends StatelessWidget {
  const ThumbnailVideo(this.index, {this.width=double.infinity,this.height=185,Key? key}) : super(key: key);
  final int index;
  final double height;
  final double width;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: width.w,
      height: height.h,
      color: ColorManager.yellow,
      child: Center(child: Text("$index")),
    );
  }
}
