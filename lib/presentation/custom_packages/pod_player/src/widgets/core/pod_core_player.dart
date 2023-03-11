import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';
import 'package:youtube/core/resources/color_manager.dart';
import 'package:youtube/presentation/custom_packages/pod_player/src/controllers/pod_getx_video_controller.dart';
import 'package:youtube/presentation/custom_packages/pod_player/src/utils/enums.dart';
import 'package:youtube/presentation/custom_packages/pod_player/src/widgets/core/overlays/overlays.dart';
import 'package:youtube/presentation/custom_packages/pod_player/src/widgets/pod_progress_bar.dart';

class PodCoreVideoPlayer extends StatelessWidget {
  final VideoPlayerController videoPlayerCtr;
  final double videoAspectRatio;
  final String tag;
  final bool displayOverlay;
  final bool isThatThumbnailVideo;

  const PodCoreVideoPlayer({
    Key? key,
    required this.videoPlayerCtr,
    required this.videoAspectRatio,
    required this.tag,
    this.displayOverlay = true,
    this.isThatThumbnailVideo = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final podCtr = Get.find<PodGetXVideoController>(tag: tag);
    return Builder(
      builder: (ctr) {
        return RawKeyboardListener(
          autofocus: true,
          focusNode:
              (podCtr.isFullScreen ? FocusNode() : podCtr.keyboardFocusWeb) ??
                  FocusNode(),
          onKey: (value) => podCtr.onKeyBoardEvents(
            event: value,
            appContext: ctr,
            tag: tag,
          ),
          child: Stack(
            fit: StackFit.expand,
            children: [
              Center(
                child: AspectRatio(
                  aspectRatio: videoAspectRatio,
                  child: VideoPlayer(videoPlayerCtr),
                ),
              ),
              if (displayOverlay) ...[
                if (isThatThumbnailVideo) ...[
                  _VolumeWidget(tag: tag)
                ] else ...[
                  GetBuilder<PodGetXVideoController>(
                    tag: tag,
                    id: 'podVideoState',
                    builder: (_) => GetBuilder<PodGetXVideoController>(
                      tag: tag,
                      id: 'video-progress',
                      builder: (podCtr) {
                        if (podCtr.videoThumbnail == null) {
                          return const SizedBox();
                        }

                        if (podCtr.podVideoState == PodVideoState.paused &&
                            podCtr.videoPosition == Duration.zero) {
                          return SizedBox.expand(
                            child: TweenAnimationBuilder<double>(
                              builder: (context, value, child) => Opacity(
                                opacity: value,
                                child: child,
                              ),
                              tween: Tween<double>(begin: 0.7, end: 1),
                              duration: const Duration(milliseconds: 400),
                              child: DecoratedBox(
                                decoration: BoxDecoration(
                                  image: podCtr.videoThumbnail,
                                ),
                              ),
                            ),
                          );
                        }
                        return const SizedBox();
                      },
                    ),
                  ),
                  VideoOverlays(
                      tag: tag, isThatThumbnailVideo: isThatThumbnailVideo),
                  IgnorePointer(
                    child: GetBuilder<PodGetXVideoController>(
                      tag: tag,
                      id: 'podVideoState',
                      builder: (podCtr) {
                        final loadingWidget = podCtr.onLoading?.call(context) ??
                            const Center(
                              child: CircularProgressIndicator(
                                backgroundColor: Colors.transparent,
                                color: Colors.white,
                                strokeWidth: 2,
                              ),
                            );

                        if (kIsWeb) {
                          switch (podCtr.podVideoState) {
                            case PodVideoState.loading:
                              return loadingWidget;
                            case PodVideoState.paused:
                              return const Center(
                                child: Icon(
                                  Icons.play_arrow,
                                  size: 45,
                                  color: Colors.white,
                                ),
                              );
                            case PodVideoState.playing:
                              return Center(
                                child: TweenAnimationBuilder<double>(
                                  builder: (context, value, child) => Opacity(
                                    opacity: value,
                                    child: child,
                                  ),
                                  tween: Tween<double>(begin: 1, end: 0),
                                  duration: const Duration(seconds: 1),
                                  child: const Icon(
                                    Icons.pause,
                                    size: 45,
                                    color: Colors.white,
                                  ),
                                ),
                              );
                            case PodVideoState.error:
                              return const SizedBox();
                          }
                        } else {
                          if (podCtr.podVideoState == PodVideoState.loading) {
                            return loadingWidget;
                          }
                          return const SizedBox();
                        }
                      },
                    ),
                  ),
                ],
                if (!kIsWeb)
                  GetBuilder<PodGetXVideoController>(
                    tag: tag,
                    id: 'full-screen',
                    builder: (podCtr) => podCtr.isFullScreen
                        ? const SizedBox()
                        : GetBuilder<PodGetXVideoController>(
                            tag: tag,
                            id: 'overlay',
                            builder: (podCtr) => podCtr.isOverlayVisible ||
                                    !podCtr.alwaysShowProgressBar
                                ? const SizedBox()
                                : Align(
                                    alignment: Alignment.bottomCenter,
                                    child: PodProgressBar(
                                      tag: tag,
                                      alignment: Alignment.bottomCenter,
                                      podProgressBarConfig:
                                          podCtr.podProgressBarConfig,
                                      isThatThumbnailVideo:
                                          isThatThumbnailVideo,
                                    ),
                                  ),
                          ),
                  ),
              ],
            ],
          ),
        );
      },
    );
  }
}

class _VolumeWidget extends StatefulWidget {
  const _VolumeWidget({required this.tag});

  final String tag;

  @override
  State<_VolumeWidget> createState() => _VolumeWidgetState();
}

class _VolumeWidgetState extends State<_VolumeWidget> {
  bool isMute = false;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentDirectional.topEnd,
      child: Padding(
          padding: REdgeInsets.all(10),
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(3.r),
                color: BaseColorManager.black54),
            padding: REdgeInsets.symmetric(horizontal: 10, vertical: 3),
            child: InkWell(
                onTap: () async {
                  final logic =
                      Get.find<PodGetXVideoController>(tag: widget.tag);

                  if (isMute) {
                    await logic.unMute();
                  } else {
                    await logic.mute();
                  }
                  setState(() => isMute = !isMute);
                },
                child: Icon(
                  isMute ? Icons.volume_off_rounded : Icons.volume_up_rounded,
                  size: 25,
                  color: BaseColorManager.white,
                )),
          )),
    );
  }
}
