import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:youtube/core/resources/color_manager.dart';
import 'package:youtube/core/resources/styles_manager.dart';
import 'package:youtube/presentation/pages/home/logic/home_page_logic.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(slivers: [
          const _CustomSliverAppBar(),
          SliverList(
              delegate: SliverChildBuilderDelegate(
            childCount: 30,
            (context, index) =>  _VideoItemList(index),
          )),
        ]),
      ),
    );
  }
}

class _CustomSliverAppBar extends StatelessWidget {
  const _CustomSliverAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      floating: true,
      leading: const Icon(Icons.yard_outlined, size: 40),
      actionsIconTheme: const IconThemeData(size: 20),
      actions: const [
        Icon(Icons.search_rounded, size: 25),
        RSizedBox(width: 20),
        Icon(Icons.search_rounded, size: 25),
        RSizedBox(width: 20),
        Icon(Icons.search_rounded, size: 25),
        RSizedBox(width: 20),
        CircleAvatar(backgroundColor: ColorManager.teal, radius: 13),
        RSizedBox(width: 20),
      ],
      bottom: PreferredSize(
          preferredSize: Size.fromHeight(50.h),
          child: Container(
            width: MediaQuery.of(context).size.width,
            color: ColorManager.green,
            height: 50.h,
          )),
    );
  }
}

class _VideoItemList extends StatelessWidget {
  const _VideoItemList(this.index);
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
            children: const [_Thumbnail(), _VideoTime()],
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
                Text("Flutter youtube fully clone With firebase",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: getMediumStyle(
                        fontSize: 15, color: ColorManager(context).black)),
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

class _Thumbnail extends StatelessWidget {
  const _Thumbnail();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 185.h,
      color: ColorManager.yellow,
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
