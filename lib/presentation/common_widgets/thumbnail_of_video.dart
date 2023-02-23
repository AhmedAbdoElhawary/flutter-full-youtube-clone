import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:youtube/core/functions/reformat/views_reformat.dart';
import 'package:youtube/core/resources/assets_manager.dart';
import 'package:youtube/data/models/channel_details/channel_details.dart';
import 'package:youtube/data/models/videos_details/video_details_extension.dart';
import 'package:youtube/data/models/videos_details/videos_details.dart';
import 'package:youtube/presentation/common_widgets/circular_profile_image.dart';
import 'package:youtube/presentation/common_widgets/thumbnail_image.dart';

import '../../core/resources/color_manager.dart';
import '../../core/resources/styles_manager.dart';
import '../pages/home/logic/home_page_logic.dart';

class ThumbnailOfVideo extends StatelessWidget {
  const ThumbnailOfVideo(this.videoDetailsItem, {super.key});
  final VideoDetailsItem? videoDetailsItem;
  @override
  Widget build(BuildContext context) {
    final miniVideoViewLogic = Get.find<MiniVideoViewLogic>(tag: "1");
    return InkWell(
      onTap: () {
        miniVideoViewLogic.selectedVideoDetails = videoDetailsItem;
      },
      child: Column(
        children: [
          Stack(
            alignment: AlignmentDirectional.bottomEnd,
            children: [
              if (videoDetailsItem?.snippet?.thumbnails != null)
                ThumbnailImage(videoDetailsItem?.snippet?.thumbnails),
              _VideoTime(videoDetailsItem)
            ],
          ),
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

class _VideoTime extends StatelessWidget {
  const _VideoTime(this.videoDetailsItem);
  final VideoDetailsItem? videoDetailsItem;

  @override
  Widget build(BuildContext context) {
    String duration = videoDetailsItem?.contentDetails.duration ?? "";
    String durationReformat = CountsReformat.videoDurationFormat(duration);
    return Padding(
      padding: REdgeInsets.all(8.0),
      child: Container(
        padding: REdgeInsets.symmetric(horizontal: 2, vertical: 1.5),
        decoration: BoxDecoration(
            color: ColorManager(context).black87,
            borderRadius: BorderRadius.circular(2)),
        child: Text(
          durationReformat,
          style:
              getMediumStyle(color: ColorManager(context).white, fontSize: 12),
        ),
      ),
    );
  }
}
