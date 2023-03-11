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
import 'package:youtube/presentation/custom_packages/pod_player/src/pod_player.dart';

import '../../core/resources/color_manager.dart';
import '../../core/resources/styles_manager.dart';
import '../custom_packages/pod_player/src/controllers/pod_player_controller.dart';
import '../custom_packages/pod_player/src/models/play_video_from.dart';
import '../pages/home/logic/home_page_logic.dart';

class ThumbnailOfVideo extends StatelessWidget {
  const ThumbnailOfVideo(this.videoDetailsItem,
      {this.enablePlaying = true, this.playVideo = false, super.key});
  final VideoDetailsItem? videoDetailsItem;
  final bool enablePlaying;
  final bool playVideo;
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
              Obx(() {
                final logic = Get.find<MiniVideoViewLogic>(tag: "1");

                return logic.selectedVideoDetails == null
                    ? _VideoDisplay(videoDetailsItem)
                    : ThumbnailImage(videoDetailsItem?.getVideoThumbnails(),
                        borderRadius: 0,
                        childAboveImage: VideoDurationWidget(videoDetailsItem));
              })
            ] else ...[
              ThumbnailImage(videoDetailsItem?.getVideoThumbnails(),
                  borderRadius: 0,
                  childAboveImage: VideoDurationWidget(videoDetailsItem)),
            ],
          ],
          const RSizedBox(height: 10),
          _VideoSubTitles(videoDetailsItem),
          const RSizedBox(height: 15),
        ],
      ),
    );
  }
}

class _VideoDisplay extends StatefulWidget {
  const _VideoDisplay(this.videoDetailsItem);
  final VideoDetailsItem? videoDetailsItem;

  @override
  State<_VideoDisplay> createState() => _VideoDisplayState();
}

class _VideoDisplayState extends State<_VideoDisplay> {
  PodPlayerController? videoController =
      Get.find<MiniVideoViewLogic>(tag: "1").thumbnailVideoController;

  Future<void> _changeController(String videoId) async {
    if (videoId.isNotEmpty && videoController != null) {
      await videoController?.changeVideo(
          playVideoFrom: getPlayVideoFrom(videoId), playVideoDirectly: true);
    }
  }

  static PlayVideoFrom getPlayVideoFrom(String videoId) =>
      PlayVideoFrom.youtube(_url(videoId));

  static String _url(String videoId) => 'https://youtu.be/$videoId';

  void _firstInitialized(String videoId) {
    videoController = PodPlayerController(
      playVideoFrom: getPlayVideoFrom(videoId),
      getTag: "mini 2",
    )..initialise();
  }


  @override
  void didUpdateWidget(covariant _VideoDisplay oldWidget) {
    videoController?.play();
    super.didUpdateWidget(oldWidget);
  }
  @override
  void didChangeDependencies() {
    videoController?.play();
    super.didChangeDependencies();
  }
  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      String videoId = widget.videoDetailsItem?.id ?? "";

      if (videoController?.isInitialised ?? false) {
        _changeController(videoId);
      } else {
        _firstInitialized(videoId);
      }
    });
    String url = widget.videoDetailsItem?.getVideoThumbnails()?.max?.url ?? "";
    return Container(
      height: 185.h,
      width: double.infinity,
      color: ColorManager(context).grey1,
      child: videoController == null
          ? null
          : CustomPodVideoPlayer(
              controller: videoController!,
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
  const _VideoSubTitles(this.videoItem);
  final VideoDetailsItem? videoItem;

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
                        fontSize: 13, color: ColorManager(context).grey7)),
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
