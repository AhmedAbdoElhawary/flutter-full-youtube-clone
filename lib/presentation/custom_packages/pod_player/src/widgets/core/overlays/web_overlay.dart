import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:youtube/presentation/custom_packages/pod_player/src/controllers/pod_getx_video_controller.dart';
import 'package:youtube/presentation/custom_packages/pod_player/src/widgets/animated_play_pause_icon.dart';
import 'package:youtube/presentation/custom_packages/pod_player/src/widgets/core/overlays/mobile_overlay.dart';
import 'package:youtube/presentation/custom_packages/pod_player/src/widgets/core/overlays/web_dropdown_menu.dart';
import 'package:youtube/presentation/custom_packages/pod_player/src/widgets/core/video_gesture_detector.dart';
import 'package:youtube/presentation/custom_packages/pod_player/src/widgets/material_icon_button.dart';
import 'package:youtube/presentation/custom_packages/pod_player/src/widgets/pod_progress_bar.dart';
import 'package:universal_html/html.dart' as html;

class WebOverlay extends StatelessWidget {
  final String tag;
   final bool isThatThumbnailVideo;

  const WebOverlay({
    Key? key,
    required this.tag,
    required this.isThatThumbnailVideo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const overlayColor = Colors.black38;
    final podCtr = Get.find<PodGetXVideoController>(tag: tag);
    return Stack(
      children: [
        Positioned.fill(
          child: VideoGestureDetector(
            tag: tag,
            onTap: podCtr.togglePlayPauseVideo,
            onDoubleTap: () => podCtr.toggleFullScreenOnWeb(context, tag),
            child: const ColoredBox(
              color: overlayColor,
              child: SizedBox.expand(),
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomLeft,
          child: _WebOverlayBottomControlles(
            tag: tag,
            isThatThumbnailVideo: isThatThumbnailVideo,
          ),
        ),
        Positioned.fill(
          child: Row(
            children: [
              Expanded(
                child: IgnorePointer(
                  child: LeftRightDoubleTapBox(
                    tag: tag,
                    isLeft: true,
                  ),
                ),
              ),
              Expanded(
                child: IgnorePointer(
                  child: LeftRightDoubleTapBox(
                    tag: tag,
                    isLeft: false,
                  ),
                ),
              ),
            ],
          ),
        ),
        IgnorePointer(child: podCtr.videoTitle ?? const SizedBox()),
      ],
    );
  }
}

class _WebOverlayBottomControlles extends StatelessWidget {
  final String tag;
  final bool isThatThumbnailVideo;

  const _WebOverlayBottomControlles({
    Key? key,
    required this.tag,
    required this.isThatThumbnailVideo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final podCtr = Get.find<PodGetXVideoController>(tag: tag);
    const durationTextStyle = TextStyle(color: Colors.white70);
    const itemColor = Colors.white;

    return MouseRegion(
      onHover: (event) => podCtr.onOverlayHover(),
      onExit: (event) => podCtr.onOverlayHoverExit(),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            PodProgressBar(
              tag: tag,
              podProgressBarConfig: podCtr.podProgressBarConfig,
              isThatThumbnailVideo: isThatThumbnailVideo,
            ),
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    alignment: Alignment.centerLeft,
                    child: Row(
                      children: [
                        AnimatedPlayPauseIcon(tag: tag),
                        GetBuilder<PodGetXVideoController>(
                          tag: tag,
                          id: 'volume',
                          builder: (podCtr) => MaterialIconButton(
                            toolTipMsg: podCtr.isMute
                                ? podCtr.podPlayerLabels.unmute ??
                                    'Unmute${kIsWeb ? ' (m)' : ''}'
                                : podCtr.podPlayerLabels.mute ??
                                    'Mute${kIsWeb ? ' (m)' : ''}',
                            color: itemColor,
                            onPressed: podCtr.toggleMute,
                            child: Icon(
                              podCtr.isMute
                                  ? Icons.volume_off_rounded
                                  : Icons.volume_up_rounded,
                            ),
                          ),
                        ),
                        GetBuilder<PodGetXVideoController>(
                          tag: tag,
                          id: 'video-progress',
                          builder: (podCtr) {
                            return Row(
                              children: [
                                Text(
                                  podCtr.calculateVideoDuration(
                                    podCtr.videoPosition,
                                  ),
                                  style: durationTextStyle,
                                ),
                                const Text(
                                  ' / ',
                                  style: durationTextStyle,
                                ),
                                Text(
                                  podCtr.calculateVideoDuration(
                                    podCtr.videoDuration,
                                  ),
                                  style: durationTextStyle,
                                ),
                              ],
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    alignment: Alignment.centerRight,
                    child: Row(
                      children: [
                        WebSettingsDropdown(tag: tag),
                        MaterialIconButton(
                          toolTipMsg: podCtr.isFullScreen
                              ? podCtr.podPlayerLabels.exitFullScreen ??
                                  'Exit full screen${kIsWeb ? ' (f)' : ''}'
                              : podCtr.podPlayerLabels.fullscreen ??
                                  'Fullscreen${kIsWeb ? ' (f)' : ''}',
                          color: itemColor,
                          onPressed: () => _onFullScreenToggle(podCtr, context),
                          child: Icon(
                            podCtr.isFullScreen
                                ? Icons.fullscreen_exit
                                : Icons.fullscreen,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _onFullScreenToggle(
    PodGetXVideoController podCtr,
    BuildContext context,
  ) {
    if (podCtr.isOverlayVisible) {
      if (podCtr.isFullScreen) {
        if (kIsWeb) {
          html.document.exitFullscreen();
          podCtr.disableFullScreen(context, tag);
          return;
        } else {
          podCtr.disableFullScreen(context, tag);
        }
      } else {
        if (kIsWeb) {
          html.document.documentElement?.requestFullscreen();
          podCtr.enableFullScreen(tag);
          return;
        } else {
          podCtr.enableFullScreen(tag);
        }
      }
    } else {
      podCtr.toggleVideoOverlay();
    }
  }
}
