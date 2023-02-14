import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:youtube/data/models/common/thumbnail_details/max_thumbnail_details.dart';

import '../../core/resources/color_manager.dart';

class ThumbnailVideo extends StatelessWidget {
  const ThumbnailVideo(this.thumbnailsVideo,
      {this.width = double.infinity, this.height = 185, Key? key})
      : super(key: key);
  final MaxThumbnails? thumbnailsVideo;
  final double height;
  final double width;
  @override
  Widget build(BuildContext context) {
    String url = thumbnailsVideo?.max?.url ?? "";
    return Container(
      width: width.w,
      height: height.h,
      color: ColorManager(context).grey1,
      child: url.isNotEmpty ? Image.network(url, fit: BoxFit.cover) : null,
    );
  }
}
