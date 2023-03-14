import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:youtube/data/models/videos_details/video_details_extension.dart';
import 'package:youtube/data/models/videos_details/videos_details.dart';
import 'package:youtube/presentation/common_widgets/svg_icon.dart';
import 'package:youtube/presentation/common_widgets/thumbnail_image.dart';
import 'package:youtube/presentation/common_widgets/video_duration.dart';
import 'package:youtube/presentation/pages/home/logic/home_page_logic.dart';

import '../../../../core/resources/assets_manager.dart';
import '../../../../core/resources/color_manager.dart';
import '../../../../core/resources/styles_manager.dart';

class VideoHorizontalDescriptionsList extends StatelessWidget {
  const VideoHorizontalDescriptionsList(this.videoDetails, {super.key});
  final VideoDetailsItem videoDetails;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        final logic = Get.find<MiniVideoViewLogic>(tag: "1");
        logic.initializeVideoController(videoDetailsItem: videoDetails);
      },
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ThumbnailImage(videoDetails.getVideoThumbnails(),
              height: 80,
              width: 160,
              childAboveImage: VideoDurationWidget(videoDetails)),
          const RSizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  videoDetails.getVideoTitle(),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 3,
                  style: getNormalStyle(
                      color: ColorManager(context).black, fontSize: 14),
                ),
                const RSizedBox(height: 3),
                Text(
                  "${videoDetails.getVideoViewsCount()} views . ${videoDetails.getVideoPublishedTime()} ago",
                  style: getNormalStyle(
                      color:  BaseColorManager.grey, fontSize: 12),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
              ],
            ),
          ),
          Padding(
            padding: REdgeInsetsDirectional.only(start: 10, end: 15),
            child: const SvgIcon(IconsAssets.menuPointsVerticalIcon, size: 12),
          ),
        ],
      ),
    );
  }
}
