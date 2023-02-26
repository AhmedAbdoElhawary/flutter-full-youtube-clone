part of '../mini_player_video.dart';

class _MiniVideoView extends StatelessWidget {
  const _MiniVideoView({
    required this.height,
    required this.percentage,
  });

  final double height;
  final double percentage;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Flexible(
          child: Row(
            children: [
              _VideoOfMiniDisplay(height, percentage),
              const VideoTitleSubTitleTexts(),
              Expanded(
                flex: 1,
                child: GestureDetector(
                  child: const Icon(Icons.play_arrow),
                  onTap: () {},
                ),
              ),
              Expanded(
                flex: 1,
                child: GestureDetector(
                  child: const Icon(Icons.close),
                  onTap: () {
                    final miniVideoViewLogic =
                    Get.find<MiniVideoViewLogic>(tag: "1");
                    miniVideoViewLogic.selectedVideoDetails = null;
                  },
                ),
              ),
            ],
          ),
        ),

        /// todo
        // const LinearProgressIndicator(
        //   value: 0.4,
        //   minHeight: 2,
        //   valueColor: AlwaysStoppedAnimation<Color>(
        //     Colors.red,
        //   ),
        // ),
      ],
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
    logic.videoController = PodPlayerController(
      playVideoFrom: MiniVideoViewLogic.getPlayVideoFrom(videoId),
    )..initialise();
  }

  @override
  void dispose() {
    super.dispose();
    logic. videoController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Obx(
          () => Container(
        height: logic.videoOfMiniDisplayHeight(),
        width: logic.videoOfMiniDisplayWidth(screenWidth),
        color: ColorManager(context).grey1,
        child: videoId.isEmpty
            ? null
            : CustomPodVideoPlayer(
          controller: logic.videoController,
          displayOverlay: widget.percentage == 1,
        ),
      ),
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
