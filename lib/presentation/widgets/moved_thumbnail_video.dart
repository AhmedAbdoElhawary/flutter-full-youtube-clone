import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:youtube/core/resources/assets_manager.dart';
import 'package:youtube/presentation/widgets/circular_profile_image.dart';
import 'package:youtube/presentation/widgets/small_thumbnail_video.dart';

import '../../core/resources/color_manager.dart';
import '../../core/resources/styles_manager.dart';
import '../pages/home/logic/home_page_logic.dart';

class MovedThumbnailVideo extends StatelessWidget {
  const MovedThumbnailVideo(this.index, {super.key});
  final int index;
  @override
  Widget build(BuildContext context) {
    final miniVideoViewLogic = Get.find<MiniVideoViewLogic>(tag: "1");

    return InkWell(
      onTap: () {
        miniVideoViewLogic.videoIndex.value = index;
      },
      child: Column(
        children: [
          Stack(
            alignment: AlignmentDirectional.bottomEnd,
            children: [ThumbnailVideo(index), const _VideoTime()],
          ),
          const RSizedBox(height: 10),
          const _VideoSubTitles(),
        ],
      ),
    );
  }
}

class _VideoSubTitles extends StatelessWidget {
  const _VideoSubTitles();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: REdgeInsets.symmetric(horizontal: 13),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CircularProfileImage(),
          const RSizedBox(width: 10),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Flutter youtube fully clone With firebase " * 2,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: getMediumStyle(
                        fontSize: 14, color: ColorManager(context).black)),
                const RSizedBox(height: 5),
                Text("Flutter channel . 3.4k views . 9 months ago",
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
  const _VideoTime();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: REdgeInsets.all(8.0),
      child: Container(
        padding: REdgeInsets.symmetric(horizontal: 2, vertical: 1.5),
        decoration: BoxDecoration(
            color: ColorManager(context).black87,
            borderRadius: BorderRadius.circular(2)),
        child: Text(
          "18:14",
          style:
              getMediumStyle(color: ColorManager(context).white, fontSize: 12),
        ),
      ),
    );
  }
}