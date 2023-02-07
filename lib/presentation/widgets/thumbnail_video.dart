import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../core/resources/color_manager.dart';
import '../../core/resources/styles_manager.dart';
import '../pages/home/logic/home_page_logic.dart';

class ThumbnailVideoItem extends StatelessWidget {
  const ThumbnailVideoItem(this.index, {super.key});
  final int index;
  @override
  Widget build(BuildContext context) {
    final miniVideoViewLogic = Get.find<MiniVideoViewLogic>(tag: "1");

    return InkWell(
      onTap: () {
        miniVideoViewLogic.videoIndex.value=index;
      },
      child: Column(
        children: [
          Stack(
            alignment: AlignmentDirectional.bottomEnd,
            children:  [ThumbnailVideo(index),const _VideoTime()],
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
          CircleAvatar(
            radius: 18.r,
            backgroundColor: ColorManager(context).grey,
          ),
          const RSizedBox(width: 10),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Flutter youtube fully clone With firebase "*2,
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
          const Icon(Icons.circle, size: 10),
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

class ThumbnailVideo extends StatelessWidget {
  const ThumbnailVideo(this.index,{Key? key}) : super(key: key);
  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 185.h,
      color: ColorManager.yellow,
        child: Center(child: Text("$index")),
    );
  }
}
