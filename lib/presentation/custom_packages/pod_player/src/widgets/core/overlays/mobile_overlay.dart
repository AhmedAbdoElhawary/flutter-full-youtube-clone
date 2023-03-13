import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:youtube/core/resources/assets_manager.dart';
import 'package:youtube/core/resources/color_manager.dart';
import 'package:youtube/presentation/common_widgets/svg_icon.dart';
import 'package:youtube/presentation/custom_packages/pod_player/src/controllers/pod_getx_video_controller.dart';
import 'package:youtube/presentation/custom_packages/pod_player/src/widgets/animated_play_pause_icon.dart';
import 'package:youtube/presentation/custom_packages/pod_player/src/widgets/core/overlays/mobile_bottomsheet.dart';
import 'package:youtube/presentation/custom_packages/pod_player/src/widgets/core/video_gesture_detector.dart';
import 'package:youtube/presentation/custom_packages/pod_player/src/widgets/material_icon_button.dart';
import 'package:youtube/presentation/custom_packages/sliding_sheet/src/sheet.dart';
import 'package:youtube/presentation/custom_packages/sliding_sheet/src/specs.dart';

class MobileOverlay extends StatelessWidget {
  final String tag;
  final bool isThatThumbnailVideo;

  const MobileOverlay({
    Key? key,
    required this.tag,
    required this.isThatThumbnailVideo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const overlayColor = Colors.black38;
    const itemColor = Colors.white;
    final podCtr = Get.find<PodGetXVideoController>(tag: tag);
    return Stack(
      alignment: Alignment.center,
      children: [
        Row(
          children: [
            Expanded(
              child: VideoGestureDetector(
                tag: tag,
                onDoubleTap:
                    _isRtl() ? podCtr.onRightDoubleTap : podCtr.onLeftDoubleTap,
                child: ColoredBox(
                  color: overlayColor,
                  child: LeftRightDoubleTapBox(
                    tag: tag,
                    isLeft: !_isRtl(),
                  ),
                ),
              ),
            ),
            VideoGestureDetector(
              tag: tag,
              child: ColoredBox(
                color: overlayColor,
                child: SizedBox(
                  height: double.infinity,
                  child: Center(
                    child: AnimatedPlayPauseIcon(tag: tag, size: 42),
                  ),
                ),
              ),
            ),
            Expanded(
              child: VideoGestureDetector(
                tag: tag,
                onDoubleTap:
                    _isRtl() ? podCtr.onLeftDoubleTap : podCtr.onRightDoubleTap,
                child: ColoredBox(
                  color: overlayColor,
                  child: LeftRightDoubleTapBox(
                    tag: tag,
                    isLeft: _isRtl(),
                  ),
                ),
              ),
            ),
          ],
        ),
        Align(
          alignment: Alignment.topCenter,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Expanded(
                child: IgnorePointer(
                  child: podCtr.videoTitle ?? const SizedBox(),
                ),
              ),
              MaterialIconButton(
                toolTipMsg: podCtr.podPlayerLabels.settings,
                color: itemColor,
                onPressed: () {
                  if (podCtr.isOverlayVisible) {
                    _bottomSheet(context);
                  } else {
                    podCtr.toggleVideoOverlay();
                  }
                },
                child: const SvgIcon(IconsAssets.settingsIcon,color: BaseColorManager.white,size: 22),
              ),
            ],
          ),
        ),
        Align(
          alignment: Alignment.bottomLeft,
          child: MobileOverlayBottomControlles(tag: tag,isThatThumbnailVideo: isThatThumbnailVideo),
        ),
      ],
    );
  }

  bool _isRtl() {
    final Locale locale = window.locale;
    final langs = [
      'ar', // Arabic
      'fa', // Farsi
      'he', // Hebrew
      'ps', // Pashto
      'ur', // Urdu
    ];
    for (int i = 0; i < langs.length; i++) {
      final lang = langs[i];
      if (locale.toString().contains(lang)) {
        return true;
      }
    }
    return false;
  }

  void _bottomSheet(BuildContext context) {
    showSlidingBottomSheet<void>(
      context,
      builder: (BuildContext context) => SlidingSheetDialog(
        cornerRadius: 12.r,
        shadowColor: ColorManager(context).black54,
        color: Theme.of(context).splashColor,
        margin: REdgeInsets.all(10),
        padding: REdgeInsets.only(bottom: 20),
        scrollSpec: const ScrollSpec(physics: NeverScrollableScrollPhysics()),
        builder: (context, state) => Material(child: MobileBottomSheet(tag: tag,isThatThumbnailVideo: isThatThumbnailVideo,)),

      ),
    );
  }
}

class LeftRightDoubleTapBox extends StatelessWidget {
  final String tag;
  final bool isLeft;
  const LeftRightDoubleTapBox({
    Key? key,
    required this.tag,
    required this.isLeft,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PodGetXVideoController>(
      tag: tag,
      id: 'double-tap',
      builder: (podCtr) {
        return SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: AnimatedOpacity(
            duration: const Duration(milliseconds: 200),
            opacity: podCtr.isLeftDbTapIconVisible && isLeft
                ? 1
                : podCtr.isRightDbTapIconVisible && !isLeft
                    ? 1
                    : 0,
            child: Center(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Lottie.asset(
                    isLeft ? IconsAssets.forwardLeft : IconsAssets.forwardRight,
                  ),
                  if (isLeft
                      ? podCtr.isLeftDbTapIconVisible
                      : podCtr.isRightDbTapIconVisible)
                    Transform.translate(
                      offset: const Offset(0, 40),
                      child: Text(
                        '${podCtr.isLeftDbTapIconVisible ? podCtr.leftDoubleTapduration : podCtr.rightDubleTapduration} Sec',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
