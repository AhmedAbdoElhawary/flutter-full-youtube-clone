import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:youtube/core/resources/assets_manager.dart';
import 'package:youtube/core/resources/color_manager.dart';
import 'package:youtube/core/resources/styles_manager.dart';
import 'package:youtube/presentation/common_widgets/svg_icon.dart';
import 'package:youtube/presentation/custom_packages/pod_player/src/controllers/pod_getx_video_controller.dart';
import 'package:youtube/presentation/custom_packages/pod_player/src/widgets/material_icon_button.dart';
import 'package:youtube/presentation/custom_packages/pod_player/src/widgets/pod_progress_bar.dart';
import 'package:youtube/presentation/custom_packages/sliding_sheet/src/sheet.dart';
import 'package:youtube/presentation/custom_packages/sliding_sheet/src/specs.dart';

class MobileBottomSheet extends StatelessWidget {
  final String tag;
  final bool isThatThumbnailVideo;

  const MobileBottomSheet({
    Key? key,
    required this.tag,
    required this.isThatThumbnailVideo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PodGetXVideoController>(
      tag: tag,
      builder: (podCtr) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (podCtr.vimeoOrVideoUrls.isNotEmpty)
            _BottomSheetTitles(
              title: podCtr.podPlayerLabels.quality,
              icon: const SvgIcon(IconsAssets.settingsIcon,
                  color: BaseColorManager.white, size: 22),
              subText: '${podCtr.vimeoPlayingVideoQuality}p',
              onTap: () {
                Navigator.of(context).pop();
                Timer(const Duration(milliseconds: 100), () {
                  showSlidingBottomSheet<void>(
                    context,
                    builder: (BuildContext context) => SlidingSheetDialog(
                      shadowColor: ColorManager(context).black54,
                      cornerRadius: 0,
                      color: Theme.of(context).splashColor,
                      padding: REdgeInsets.only(bottom: 20),
                      snapSpec:
                          const SnapSpec(initialSnap: 1, snappings: [.7, 1]),
                      scrollSpec: const ScrollSpec(
                          physics: NeverScrollableScrollPhysics()),
                      builder: (context, state) => Material(
                          child: SafeArea(
                        child: _VideoQualitySelectorMob(tag: tag, onTap: null),
                      )),
                    ),
                  );
                });
              },
            ),
          _BottomSheetTitles(
            title: podCtr.podPlayerLabels.loopVideo,
            icon: Icon(Icons.loop, color: ColorManager(context).black),
            subText: podCtr.isLooping
                ? podCtr.podPlayerLabels.optionEnabled
                : podCtr.podPlayerLabels.optionDisabled,
            onTap: () {
              Navigator.of(context).pop();
              podCtr.toggleLooping();
            },
          ),
          _BottomSheetTitles(
            title: podCtr.podPlayerLabels.playbackSpeed,
            icon: Icon(Icons.slow_motion_video_rounded,
                color: ColorManager(context).black),
            subText: podCtr.currentPaybackSpeed,
            onTap: () {
              Navigator.of(context).pop();
              Timer(const Duration(milliseconds: 100), () {
                showSlidingBottomSheet<void>(
                  context,
                  builder: (BuildContext context) => SlidingSheetDialog(
                    shadowColor: ColorManager(context).black54,
                    color: Theme.of(context).splashColor,
                    padding: REdgeInsets.only(bottom: 20),
                    snapSpec:
                        const SnapSpec(initialSnap: 1, snappings: [.7, 1]),
                    scrollSpec: const ScrollSpec(
                        physics: NeverScrollableScrollPhysics()),
                    builder: (context, state) => Material(
                        child: SafeArea(
                      child: _VideoPlaybackSelectorMob(tag: tag, onTap: null),
                    )),
                  ),
                );
              });
            },
          ),
        ],
      ),
    );
  }
}

class _BottomSheetTitles extends StatelessWidget {
  const _BottomSheetTitles({
    required this.title,
    required this.icon,
    required this.subText,
    required this.onTap,
  });
  final String title;
  final Widget icon;
  final String? subText;
  final VoidCallback? onTap;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: icon,
      onTap: onTap,
      title: FittedBox(
        fit: BoxFit.scaleDown,
        alignment: Alignment.centerLeft,
        child: Row(
          children: [
            Text(title,
                style: getNormalStyle(color: ColorManager(context).black)),
            if (subText != null) ...[
              const SizedBox(width: 6),
              const SizedBox(
                height: 4,
                width: 4,
                child: DecoratedBox(
                  decoration:
                      BoxDecoration(color: Colors.grey, shape: BoxShape.circle),
                ),
              ),
              const SizedBox(width: 6),
              Text(
                subText!,
                style: getNormalStyle(color: ColorManager(context).grey7),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _VideoQualitySelectorMob extends StatelessWidget {
  final void Function()? onTap;
  final String tag;

  const _VideoQualitySelectorMob({
    Key? key,
    required this.onTap,
    required this.tag,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final podCtr = Get.find<PodGetXVideoController>(tag: tag);
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: REdgeInsets.symmetric(horizontal: 20),
            child: Text(
              "Quality for current video  .  ${'${podCtr.vimeoPlayingVideoQuality}p'}",
              style: getNormalStyle(color: ColorManager(context).black),
            ),
          ),
          const RSizedBox(height: 10),
          ...podCtr.vimeoOrVideoUrls
              .map(
                (e) => ListTile(
                  title: Container(
                    padding: REdgeInsetsDirectional.only(start: 30),
                    child: Text(
                      '${e.quality}p',
                      style: getNormalStyle(color: ColorManager(context).black),
                    ),
                  ),
                  onTap: () {
                    onTap != null ? onTap!() : Navigator.of(context).pop();

                    podCtr.changeVideoQuality(e.quality);
                  },
                ),
              )
              .toList()
        ],
      ),
    );
  }
}

class _VideoPlaybackSelectorMob extends StatelessWidget {
  final void Function()? onTap;
  final String tag;

  const _VideoPlaybackSelectorMob({
    Key? key,
    required this.onTap,
    required this.tag,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final podCtr = Get.find<PodGetXVideoController>(tag: tag);
    return Column(
      children: podCtr.videoPlaybackSpeeds
          .map(
            (e) => ListTile(
              title: Text(
                e,
                style: getNormalStyle(color: ColorManager(context).black),
              ),
              onTap: () {
                onTap != null ? onTap!() : Navigator.of(context).pop();
                podCtr.setVideoPlayBack(e);
              },
            ),
          )
          .toList(),
    );
  }
}

class MobileOverlayBottomControlles extends StatelessWidget {
  final String tag;
  final bool isThatThumbnailVideo;

  const MobileOverlayBottomControlles({
    Key? key,
    required this.tag,
    required this.isThatThumbnailVideo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextStyle durationTextStyle =
        TextStyle(color: Colors.white70, fontSize: 12.sp);
    const itemColor = Colors.white;

    return GetBuilder<PodGetXVideoController>(
      tag: tag,
      id: 'full-screen',
      builder: (podCtr) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const RSizedBox(width: 15),
                GetBuilder<PodGetXVideoController>(
                  tag: tag,
                  id: 'video-progress',
                  builder: (podCtr) {
                    return Row(
                      children: [
                        Text(
                          podCtr.calculateVideoDuration(podCtr.videoPosition),
                          style: TextStyle(color: itemColor, fontSize: 12.sp),
                        ),
                        Text(
                          ' / ',
                          style: durationTextStyle,
                        ),
                        Text(
                          podCtr.calculateVideoDuration(podCtr.videoDuration),
                          style: durationTextStyle,
                        ),
                      ],
                    );
                  },
                ),
                const Spacer(),
                MaterialIconButton(
                  toolTipMsg: podCtr.isFullScreen
                      ? podCtr.podPlayerLabels.exitFullScreen ??
                          'Exit full screen${kIsWeb ? ' (f)' : ''}'
                      : podCtr.podPlayerLabels.fullscreen ??
                          'Fullscreen${kIsWeb ? ' (f)' : ''}',
                  color: itemColor,
                  onPressed: () {
                    if (podCtr.isOverlayVisible) {
                      if (podCtr.isFullScreen) {
                        podCtr.disableFullScreen(context, tag);
                      } else {
                        podCtr.enableFullScreen(tag);
                      }
                    } else {
                      podCtr.toggleVideoOverlay();
                    }
                  },
                  child: Icon(
                    podCtr.isFullScreen
                        ? Icons.fullscreen_exit
                        : Icons.fullscreen,
                  ),
                ),
                const RSizedBox(width: 6),
              ],
            ),
          ),
          GetBuilder<PodGetXVideoController>(
            tag: tag,
            id: 'overlay',
            builder: (podCtr) {
              if (podCtr.isFullScreen) {
                return Padding(
                  padding: const EdgeInsets.fromLTRB(12, 0, 12, 20),
                  child: Visibility(
                    visible: podCtr.isOverlayVisible,
                    child: PodProgressBar(
                      tag: tag,
                      alignment: Alignment.topCenter,
                      podProgressBarConfig: podCtr.podProgressBarConfig,
                      isThatThumbnailVideo: isThatThumbnailVideo,
                    ),
                  ),
                );
              }
              return PodProgressBar(
                tag: tag,
                alignment: Alignment.bottomCenter,
                podProgressBarConfig: podCtr.podProgressBarConfig,
                isThatThumbnailVideo: isThatThumbnailVideo,
              );
            },
          ),
        ],
      ),
    );
  }
}
