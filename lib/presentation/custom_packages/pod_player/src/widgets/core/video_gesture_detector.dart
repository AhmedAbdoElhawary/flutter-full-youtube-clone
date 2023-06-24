import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:youtube/presentation/custom_packages/pod_player/src/controllers/pod_getx_video_controller.dart';

class VideoGestureDetector extends StatelessWidget {
  final Widget? child;
  final void Function()? onDoubleTap;
  final void Function()? onTap;
  final String tag;

  const VideoGestureDetector({
    Key? key,
    this.child,
    this.onDoubleTap,
    this.onTap,
    required this.tag,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final podCtr = Get.find<PodGetXVideoController>(tag: tag);
    return MouseRegion(
      onHover: (event) => podCtr.onOverlayHover(),
      onExit: (event) => podCtr.onOverlayHoverExit(),
      child: GestureDetector(
        onTap: onTap ?? podCtr.toggleVideoOverlay,
        onDoubleTap: onDoubleTap,
        child: child,
      ),
    );
  }
}
