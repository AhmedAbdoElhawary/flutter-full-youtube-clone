import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:youtube/data/models/common/thumbnail_details/max_thumbnail_details.dart';
import 'package:youtube/presentation/common_widgets/custom_network_display.dart';

class ThumbnailImage extends StatefulWidget {
  const ThumbnailImage(this.thumbnailsVideo,
      {this.width = double.infinity,
      this.height = 185,
      required this.childAboveImage,
      this.borderRadius = 10,
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
          CustomNetworkDisplay(
            imageUrl: widget.thumbnailsVideo?.max?.url ?? "",
            height: widget.height,
            width: widget.width,
          ),
          widget.childAboveImage,
        ],
      ),
    );
  }
}
