import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:youtube/data/models/common/thumbnail_details/max_thumbnail_details.dart';
import 'package:youtube/data/models/common/thumbnail_details/thumbnail_details.dart';
import '../../core/resources/color_manager.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ThumbnailImage extends StatefulWidget {
  const ThumbnailImage(this.thumbnailsVideo,
      {this.width = double.infinity,
      this.height = 185,
      required this.childAboveImage,
        this.borderRadius=10,
      Key? key})
      : super(key: key);
  final MaxThumbnails? thumbnailsVideo;
  final double height;
  final double width;
  final Widget childAboveImage;
  final double borderRadius;
  @override
  State<ThumbnailImage> createState() => _NetworkDisplayState();
}

class _NetworkDisplayState extends State<ThumbnailImage> {
  void cacheImage() {
    String? url = widget.thumbnailsVideo?.max?.url;
    if (url != null) precacheImage(NetworkImage(url), context);
  }

  @override
  void didChangeDependencies() {
    cacheImage();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(widget.borderRadius.r),
      child: Stack(
        alignment: AlignmentDirectional.bottomEnd,
        children: [
          _CachedImage(
            thumbnailsVideo: widget.thumbnailsVideo,
            height: widget.height,
            width: widget.width,
          ),
          widget.childAboveImage,
        ],
      ),
    );
  }
}
class _CachedImage extends StatelessWidget {
  const _CachedImage({
    required this.thumbnailsVideo,
    required this.height,
    required this.width,
  });

  final MaxThumbnails? thumbnailsVideo;
  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    ThumbnailDetails? thumbnail = thumbnailsVideo?.max;

    return CachedNetworkImage(
      imageUrl: thumbnail?.url ?? "",
      fit: BoxFit.cover,
      width: width.w,
      height: height.h,
      memCacheHeight: thumbnail?.height,
      memCacheWidth: thumbnail?.width,
      placeholder: (context, url) => Container(
        color: ColorManager(context).grey1,
        width: width.w,
        height: height.h,
      ),
      errorWidget: (context, url, error) {
        return Container(
          color: ColorManager(context).grey1,
          width: width.w,
          height: height.h,
        );
      },
    );
  }
}
