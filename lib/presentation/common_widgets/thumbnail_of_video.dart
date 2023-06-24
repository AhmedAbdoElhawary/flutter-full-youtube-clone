import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:youtube/core/resources/assets_manager.dart';
import 'package:youtube/data/models/channel_details/channel_details.dart';
import 'package:youtube/data/models/videos_details/video_details_extension.dart';
import 'package:youtube/data/models/videos_details/videos_details.dart';
import 'package:youtube/presentation/common_widgets/circular_profile_image.dart';
import 'package:youtube/presentation/common_widgets/thumbnail_image.dart';
import 'package:youtube/presentation/common_widgets/video_duration.dart';
import 'package:youtube/presentation/custom_packages/pod_player/src/controllers/pod_player_controller.dart';
import 'package:youtube/presentation/custom_packages/pod_player/src/models/play_video_from.dart';
import 'package:youtube/presentation/custom_packages/pod_player/src/pod_player.dart';
import '../../core/resources/color_manager.dart';
import '../../core/resources/styles_manager.dart';
import '../pages/home/logic/home_page_logic.dart';

class ThumbnailOfVideo extends StatelessWidget {
  const ThumbnailOfVideo(this.videoDetailsItem,
      {this.enablePlaying = true,
      this.playVideo = false,
      this.isThatFloatingPlayer = false,
      super.key});
  final VideoDetailsItem? videoDetailsItem;
  final bool enablePlaying;
  final bool playVideo;
  final bool isThatFloatingPlayer;
  @override
  Widget build(BuildContext context) {
    bool isUrlFailed = videoDetailsItem?.getVideoThumbnails() != null;

    return InkWell(
      onTap: () {
        final logic = Get.find<MiniVideoViewLogic>(tag: "1");

        logic.initializeVideoController(videoDetailsItem: videoDetailsItem);
      },
      child: Column(
        children: [
          if (isUrlFailed) ...[
            if (playVideo && enablePlaying) ...[
              GetBuilder<MiniVideoViewLogic>(
                tag: "1",
                id: "update-selected-video",
                builder: (controller) {
                  return controller.getSelectedVideoDetails == null
                      ? MovedVideoDisplay(
                          videoDetailsItem, controller.moveThumbnailVideo)
                      : ThumbnailImage(videoDetailsItem?.getVideoThumbnails(),
                          borderRadius: 0,
                          childAboveImage:
                              VideoDurationWidget(videoDetailsItem));
                },
              ),
            ] else ...[
              ThumbnailImage(videoDetailsItem?.getVideoThumbnails(),
                  borderRadius: 0,
                  childAboveImage: VideoDurationWidget(videoDetailsItem)),
            ],
          ],
          const RSizedBox(height: 10),
          _VideoSubTitles(videoDetailsItem, isThatFloatingPlayer),
          const RSizedBox(height: 15),
        ],
      ),
    );
  }
}

class MovedVideoDisplay extends StatefulWidget {
  const MovedVideoDisplay(this.videoDetailsItem, this.moveThumbnailVideo,
      {super.key});
  final VideoDetailsItem? videoDetailsItem;
  final bool moveThumbnailVideo;

  @override
  State<MovedVideoDisplay> createState() => _MovedVideoDisplayState();
}

class _MovedVideoDisplayState extends State<MovedVideoDisplay> {
  PodPlayerController? movedVideoController;

  String getUrl(String videoId) => 'https://youtu.be/$videoId';

  void _thumbnailInitialized(String videoId) {
    movedVideoController = PodPlayerController(
      playVideoFrom: getPlayVideoFrom(videoId),
    )..initialise();
  }

  PlayVideoFrom getPlayVideoFrom(String videoId) =>
      PlayVideoFrom.youtube(getUrl(videoId));

  @override
  void initState() {
    String videoId = widget.videoDetailsItem?.id ?? "";
    _thumbnailInitialized(videoId);
    super.initState();
  }

  @override
  void didUpdateWidget(covariant MovedVideoDisplay oldWidget) {
    if (widget.moveThumbnailVideo) {
      movedVideoController?.play();
    } else {
      movedVideoController?.pause();
    }

    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    movedVideoController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String url = widget.videoDetailsItem?.getVideoThumbnails()?.max?.url ?? "";
    return Container(
      height: 189.h,
      width: double.infinity,
      color: ColorManager(context).grey1,
      child: movedVideoController == null
          ? null
          : CustomPodVideoPlayer(
              controller: movedVideoController!,
              displayOverlay: true,
              isThatThumbnailVideo: true,
              videoThumbnail: url.isEmpty
                  ? null
                  : DecorationImage(image: CachedNetworkImageProvider(url)),
            ),
    );
  }
}

class _VideoSubTitles extends StatelessWidget {
  const _VideoSubTitles(this.videoItem, this.isThatFloatingPlayer);
  final VideoDetailsItem? videoItem;
  final bool isThatFloatingPlayer;

  @override
  Widget build(BuildContext context) {
    String channelName = videoItem?.getChannelName() ?? "";
    String videoViews = videoItem?.getVideoViewsCount() ?? "";

    String date = videoItem?.getVideoPublishedTime() ?? "";
    ChannelDetailsItem? channelDetailsItem = videoItem?.getChannelSubDetails();
    String channelImage = videoItem?.getChannelProfileImageUrl() ?? "";
    String channelId = videoItem?.getChannelId() ?? "";

    return Padding(
      padding: REdgeInsets.symmetric(horizontal: 13),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircularProfileImage(
            imageUrl: channelImage,
            channelId: channelId,
            channelDetailsItem: channelDetailsItem,
            isThatFloatingPlayer: isThatFloatingPlayer,
          ),
          const RSizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(videoItem?.snippet?.title ?? "",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: getMediumStyle(
                        fontSize: 14, color: ColorManager(context).black)),
                const RSizedBox(height: 5),
                Text("$channelName . $videoViews . $date",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: getNormalStyle(
                        fontSize: 13, color: BaseColorManager.grey)),
              ],
            ),
          ),
          const RSizedBox(width: 10),
          SvgPicture.asset(IconsAssets.menuPointsVerticalIcon),
        ],
      ),
    );
  }
}
