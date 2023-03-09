part of '../mini_player_video.dart';

class _MiniVideoView extends StatelessWidget {
  const _MiniVideoView({
    required this.height,
    required this.percentage,
    required this.isPlaying,
    required this.durationVideoValue,
  });

  final double height;
  final double percentage;
  final bool isPlaying;
  final double durationVideoValue;
  @override
  Widget build(BuildContext context) {
    double value = (1 - percentage * 12);
    double opacity = value <= 0 ? 0 : (value > 1 ? 1 : value);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Flexible(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              _VideoOfMiniDisplay(height, percentage),
              const VideoTitleSubTitleTexts(),
              _PlayPauseButtons(isPlaying: isPlaying),
              Expanded(
                flex: 1,
                child: GestureDetector(
                  child: const Icon(Icons.close),
                  onTap: () {
                    final miniVideoViewLogic =
                        Get.find<MiniVideoViewLogic>(tag: "1");

                    miniVideoViewLogic.selectedVideoDetails = null;
                    miniVideoViewLogic.isMiniVideoInitialized.value = false;
                    try {
                      miniVideoViewLogic.videoController?.dispose();
                    } catch (e) {
                      rethrow;
                    }
                  },
                ),
              ),
            ],
          ),
        ),
        AnimatedOpacity(
          opacity: opacity,
          duration: const Duration(milliseconds: 50),
          child: Align(
            alignment: AlignmentDirectional.bottomStart,
            child: LinearProgressIndicator(
              value: durationVideoValue,
              minHeight: 2,
              valueColor: const AlwaysStoppedAnimation<Color>(Colors.red),
            ),
          ),
        ),
      ],
    );
  }
}

class _PlayPauseButtons extends StatefulWidget {
  const _PlayPauseButtons({required this.isPlaying});

  final bool isPlaying;

  @override
  State<_PlayPauseButtons> createState() => _PlayPauseButtonsState();
}

class _PlayPauseButtonsState extends State<_PlayPauseButtons> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<MiniVideoViewLogic>(
      tag: "1",
      id: "update mini player",
      builder: (controller) {
        return Expanded(
          flex: 1,
          child: GestureDetector(
            child: controller.isMiniVideoPlaying
                ? const Icon(Icons.pause)
                : const Icon(Icons.play_arrow),
            onTap: () {
              if (controller.isMiniVideoPlaying) {
                controller.videoController?.pause();
              } else {
                controller.videoController?.play();
              }
            },
          ),
        );
      },
    );
  }
}

class _VideoOfMiniDisplay extends StatefulWidget {
  const _VideoOfMiniDisplay(this.height, this.percentage);
  final double height;
  final double percentage;

  @override
  State<_VideoOfMiniDisplay> createState() => _VideoOfMiniDisplayState();
}

class _VideoOfMiniDisplayState extends State<_VideoOfMiniDisplay> {
  final logic = Get.find<MiniVideoViewLogic>(tag: "1");
  String videoId = "";
  @override
  void initState() {
    super.initState();
    videoId = logic.selectedVideoDetails?.id ?? "";
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Obx(
      () {
        double width = logic.videoOfMiniDisplayWidth(screenWidth);
        double height = logic.videoOfMiniDisplayHeight(
            percentage: widget.percentage, screenHeight: widget.height);
        return Container(
          height: height,
          width: width,
          color: ColorManager(context).grey1,
          child: videoId.isEmpty
              ? null
              : CustomPodVideoPlayer(
                  controller: logic.videoController!,
                  displayOverlay: widget.percentage == 1,
                  frameAspectRatio: width / height,
                  videoAspectRatio: width / height,
                  matchVideoAspectRatioToFrame: true,
                ),
        );
      },
    );
  }
}

class VideoTitleSubTitleTexts extends StatelessWidget {
  const VideoTitleSubTitleTexts({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 3,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Obx(
          () {
            final logic = Get.find<MiniVideoViewLogic>(tag: "1");
            VideoDetailsItem? videoDetails = logic.selectedVideoDetails;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Flexible(
                  child: Text(
                    videoDetails?.getVideoTitle() ?? "",
                    overflow: TextOverflow.ellipsis,
                    style: getNormalStyle(
                        color: ColorManager(context).black, fontSize: 12),
                  ),
                ),
                Flexible(
                  child: Text(
                    videoDetails?.getChannelName() ?? "",
                    overflow: TextOverflow.ellipsis,
                    style: getNormalStyle(
                        color: ColorManager(context).grey7, fontSize: 12),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
