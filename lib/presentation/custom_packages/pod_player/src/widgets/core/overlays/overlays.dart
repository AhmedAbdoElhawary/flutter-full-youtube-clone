import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:youtube/presentation/custom_packages/pod_player/src/controllers/pod_getx_video_controller.dart';
import 'package:youtube/presentation/custom_packages/pod_player/src/models/overlay_options.dart';
import 'package:youtube/presentation/custom_packages/pod_player/src/widgets/core/overlays/mobile_overlay.dart';
import 'package:youtube/presentation/custom_packages/pod_player/src/widgets/core/overlays/web_overlay.dart';
import 'package:youtube/presentation/custom_packages/pod_player/src/widgets/pod_progress_bar.dart';

class VideoOverlays extends StatelessWidget {
  final String tag;
  final bool isThatThumbnailVideo;

  const VideoOverlays({
    Key? key,
    required this.tag,
    required this.isThatThumbnailVideo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final podCtr = Get.find<PodGetXVideoController>(tag: tag);
    if (podCtr.overlayBuilder != null) {
      return GetBuilder<PodGetXVideoController>(
        id: 'update-all',
        tag: tag,
        builder: (podCtr) {
          ///Custom overlay
          final progressBar = PodProgressBar(
            tag: tag,
            podProgressBarConfig: podCtr.podProgressBarConfig,
            isThatThumbnailVideo: isThatThumbnailVideo,
          );
          final overlayOptions = OverLayOptions(
            podVideoState: podCtr.podVideoState,
            videoDuration: podCtr.videoDuration,
            videoPosition: podCtr.videoPosition,
            isFullScreen: podCtr.isFullScreen,
            isLooping: podCtr.isLooping,
            isOverlayVisible: podCtr.isOverlayVisible,
            isMute: podCtr.isMute,
            autoPlay: true,
            currentVideoPlaybackSpeed: podCtr.currentPaybackSpeed,
            videoPlayBackSpeeds: podCtr.videoPlaybackSpeeds,
            videoPlayerType: podCtr.videoPlayerType,
            podProgresssBar: progressBar,
          );

          /// Returns the custom overlay, otherwise returns the default
          /// overlay with gesture detector
          return podCtr.overlayBuilder!(overlayOptions);
        },
      );
    } else {
      ///Built in overlay
      return GetBuilder<PodGetXVideoController>(
        tag: tag,
        id: 'overlay',
        builder: (podCtr) {
          return AnimatedOpacity(
            duration: const Duration(milliseconds: 200),
            opacity: podCtr.isOverlayVisible ? 1 : 0,
            child: Stack(
              fit: StackFit.passthrough,
              children: [
                if (!kIsWeb)
                  MobileOverlay(
                      tag: tag, isThatThumbnailVideo: isThatThumbnailVideo),
                if (kIsWeb)
                  WebOverlay(
                      tag: tag, isThatThumbnailVideo: isThatThumbnailVideo),
              ],
            ),
          );
        },
      );
    }
  }
}
