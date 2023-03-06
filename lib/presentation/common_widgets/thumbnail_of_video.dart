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
import 'package:youtube/presentation/custom_packages/custom_mini_player/custom_mini_player.dart';

import '../../core/resources/color_manager.dart';
import '../../core/resources/styles_manager.dart';
import '../pages/home/logic/home_page_logic.dart';

class ThumbnailOfVideo extends StatelessWidget {
  const ThumbnailOfVideo(this.videoDetailsItem,
      {this.enablePlaying = true, super.key});
  final VideoDetailsItem? videoDetailsItem;
  final bool enablePlaying;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        final logic = Get.find<MiniVideoViewLogic>(tag: "1");

        logic.selectedVideoDetails = videoDetailsItem;
        logic.miniPlayerController.dispose();
        logic.miniPlayerController = MiniPlayerController();
        String videoId = logic.selectedVideoDetails?.id ?? "";

        String url = 'https://youtu.be/$videoId';

        if ((logic.videoController?.isInitialised ?? false) &&
            logic.videoController?.videoUrl == url) return;

        if (videoId.isNotEmpty && logic.videoController != null) {
          logic.videoController?.changeVideo(
            playVideoFrom: logic.getPlayVideoFrom(videoId),
          );
        }
      },
      child: Column(
        children: [
          if (videoDetailsItem?.getVideoThumbnails() != null)
            ThumbnailImage(videoDetailsItem?.getVideoThumbnails(),
                borderRadius: 0,
                childAboveImage: VideoDurationWidget(videoDetailsItem)),
          const RSizedBox(height: 10),
          _VideoSubTitles(videoDetailsItem),
          const RSizedBox(height: 15),
        ],
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
