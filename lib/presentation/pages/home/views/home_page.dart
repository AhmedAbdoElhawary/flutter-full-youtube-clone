import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:youtube/core/resources/color_manager.dart';
import 'package:youtube/presentation/widgets/thumbnail_video.dart';

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
            (context, index) =>  ThumbnailVideoItem(index),
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
