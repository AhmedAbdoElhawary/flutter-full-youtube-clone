import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:youtube/data/models/videos_details/video_details_extension.dart';
import 'package:youtube/data/models/videos_details/videos_details.dart';
import 'package:youtube/presentation/common_widgets/thumbnail_image.dart';

import '../../../../core/resources/assets_manager.dart';
import '../../../../core/resources/color_manager.dart';
import '../../../../core/resources/styles_manager.dart';

class VideoHorizontalDescriptionsList extends StatelessWidget {
  const VideoHorizontalDescriptionsList(this.videoDetails, {super.key});
  final VideoDetailsItem videoDetails;
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ThumbnailImage(videoDetails.getVideoThumbnails(),height: 80, width: 160),
        const RSizedBox(width: 15),
        Flexible(
          child: Column(
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
                    color: ColorManager(context).grey7, fontSize: 12),
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
            ],
          ),
        ),
        Padding(
          padding: REdgeInsetsDirectional.only(start: 10, end: 15),
          child:
              SvgPicture.asset(IconsAssets.menuPointsVerticalIcon, height: 12),
        ),
      ],
    );
  }
}
