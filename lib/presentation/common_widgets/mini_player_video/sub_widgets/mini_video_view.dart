part of '../mini_player_video.dart';

class _MiniVideoView extends StatelessWidget {
  const _MiniVideoView({
    required this.percentage,
    required this.durationVideoValue,
  });

  final double percentage;
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
              const _VideoOfMiniDisplay(),
              if (percentage <= 0.4) ...[
                const VideoTitleSubTitleTexts(),
                const _PlayPauseButtons(),
                const _CloseButton(),
              ],
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
              minHeight: 1.5.h,
              backgroundColor: BaseColorManager.transparentGrey,
              valueColor: const AlwaysStoppedAnimation<Color>(Colors.red),
            ),
          ),
        ),
      ],
    );
  }
}

class _CloseButton extends StatelessWidget {
  const _CloseButton();

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: GestureDetector(
        child: const Icon(Icons.close),
        onTap: () {
          final miniVideoViewLogic = Get.find<MiniVideoViewLogic>(tag: "1");

          miniVideoViewLogic.setSelectedVideoDetails = null;
          miniVideoViewLogic.isMiniVideoInitialized.value = false;
          try {
            miniVideoViewLogic.floatingVideoController?.dispose();
          } catch (e) {
            rethrow;
          }
        },
      ),
    );
  }
}

class _PlayPauseButtons extends StatefulWidget {
  const _PlayPauseButtons();

  @override
  State<_PlayPauseButtons> createState() => _PlayPauseButtonsState();
}

class _PlayPauseButtonsState extends State<_PlayPauseButtons> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<MiniVideoViewLogic>(
      tag: "1",
      id: "update-mini-player",
      builder: (controller) {
        return Expanded(
          flex: 1,
          child: GestureDetector(
            child: controller.isMiniVideoPlaying
                ? const Icon(Icons.pause)
                : const Icon(Icons.play_arrow),
            onTap: () {
              if (controller.isMiniVideoPlaying) {
                controller.floatingVideoController?.pause();
              } else {
                controller.floatingVideoController?.play();
              }
            },
          ),
        );
      },
    );
  }
}

class _VideoOfMiniDisplay extends StatelessWidget {
  const _VideoOfMiniDisplay();

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return GetBuilder<MiniVideoViewLogic>(
      tag: "1",
      id: "update-mini-player",
      builder: (controller) {
        double width = controller.videoOfMiniDisplayWidth(screenWidth);
        double height = controller.videoOfMiniDisplayHeight();
        String videoId = controller.getSelectedVideoDetails?.id ?? "";
        return Container(
          height: height,
          width: width,
          color: ColorManager(context).grey1,
          child: videoId.isEmpty
              ? null
              : CustomPodVideoPlayer(
                  controller: controller.floatingVideoController!,
                  displayOverlay: controller.percentageOFMiniPage == 1,
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
        child: GetBuilder<MiniVideoViewLogic>(
          tag: "1",
          id: "update-selected-video",
          builder: (logic) {
            VideoDetailsItem? videoDetails = logic.getSelectedVideoDetails;

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
