import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/resources/color_manager.dart';
import 'package:cached_network_image/cached_network_image.dart';

class CustomNetworkDisplay extends StatefulWidget {
  const CustomNetworkDisplay(
      {required this.imageUrl,this.width = double.infinity, this.height = 90, Key? key})
      : super(key: key);
  final String imageUrl;
  final double height;
  final double width;
  @override
  State<CustomNetworkDisplay> createState() => _CustomNetworkDisplayState();
}

class _CustomNetworkDisplayState extends State<CustomNetworkDisplay> {
  void cacheImage() {
     precacheImage(NetworkImage(widget.imageUrl), context);
  }

  @override
  void didChangeDependencies() {
    cacheImage();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {

    return CachedNetworkImage(
      imageUrl: widget.imageUrl,
      fit: BoxFit.cover,
      width: widget.width.w,
      height: widget.height.h,
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
