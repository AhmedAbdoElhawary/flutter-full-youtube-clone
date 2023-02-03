import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:youtube/core/resources/color_manager.dart';
import 'package:youtube/core/resources/styles_manager.dart';
import 'package:youtube/core/widgets/custom_app_bar.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar.mainAppBar(),
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          const _VideosListView(),
          Container(width: double.infinity,height: 50,color: ColorManager(context).black,)
        ],
      ),
    );
  }
}

class _VideosListView extends StatelessWidget {
  const _VideosListView();

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        itemBuilder: (context, index) => Column(
              children: [
                Stack(
                  alignment: AlignmentDirectional.bottomEnd,
                  children: const [_Thumbnail(), _VideoTime()],
                ),
                const RSizedBox(height: 10),
                const _VideoSubTitles(),
              ],
            ),
        separatorBuilder: (context, index) => const RSizedBox(height: 15),
        itemCount: 20);
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
        padding: REdgeInsets.symmetric(horizontal: 2, vertical: 1),
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
