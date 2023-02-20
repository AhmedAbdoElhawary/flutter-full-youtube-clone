import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:youtube/data/models/common/thumbnail_details/max_thumbnail_details.dart';
import 'package:youtube/data/models/common/thumbnail_details/thumbnail_details.dart';
import '../../core/resources/color_manager.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ThumbnailImage extends StatefulWidget {
  const ThumbnailImage(this.thumbnailsVideo,
      {this.width = double.infinity, this.height = 185, Key? key})
      : super(key: key);
  final MaxThumbnails? thumbnailsVideo;
  final double height;
  final double width;
  @override
  State<ThumbnailImage> createState() => _NetworkDisplayState();
}

class _NetworkDisplayState extends State<ThumbnailImage> {
  @override
  Widget build(BuildContext context) {
    ThumbnailDetails? thumbnail = widget.thumbnailsVideo?.max;
    print(
        "=========================> ${widget.thumbnailsVideo?.high?.url}${widget.thumbnailsVideo?.max?.url}");

    return CachedNetworkImage(
      imageUrl: thumbnail?.url ?? "",
      fit: BoxFit.cover,
      width: widget.width.w,
      height: widget.height.h,
      memCacheHeight: thumbnail?.height,
      memCacheWidth: thumbnail?.width,
      placeholder: (context, url) => Container(
        color: ColorManager(context).grey1,
        width: widget.width.w,
        height: widget.height.h,
      ),
      errorWidget: (context, url, error) =>
          Center(child: Text(error.toString())),
    );
  }
}
