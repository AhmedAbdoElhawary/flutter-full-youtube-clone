import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:youtube/core/resources/color_manager.dart';
import 'package:youtube/presentation/widgets/moved_thumbnail_video.dart';

import '../../../../core/widgets/sliver_app_bar.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            MainSliverAppBar(
              preferredSizeWidget: PreferredSize(
                preferredSize: Size.fromHeight(50.h),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  color: ColorManager.green,
                  height: 50.h,
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                childCount: 30,
                (context, index) => Padding(
                  padding: REdgeInsets.only(bottom: 15),
                  child: MovedThumbnailVideo(index),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
