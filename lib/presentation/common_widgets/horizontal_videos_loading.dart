import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:youtube/core/resources/color_manager.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SliverHorizontalVideosShimmerLoading extends StatelessWidget {
  const SliverHorizontalVideosShimmerLoading(
      {this.isThatForPlaylist = false, super.key});
  final bool isThatForPlaylist;
  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        childCount: 20,
        (context, index) => Shimmer.fromColors(
          baseColor: ColorManager(context).grey1,
          highlightColor: ColorManager(context).greyPoint5,
          child: Padding(
            padding: REdgeInsetsDirectional.only(start: 15, top: 15),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10.r),
                  child: Container(
                    height: 80,
                    width: 160,
                    color: ColorManager(context).grey2,
                  ),
                ),
                const RSizedBox(width: 15),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                          width: 130.w,
                          height: 10.h,
                          color: ColorManager(context).grey2),
                      const RSizedBox(height: 8),
                      Container(
                          width: 90.w,
                          height: 10.h,
                          color: ColorManager(context).grey2),
                      if (!isThatForPlaylist) ...[
                        const RSizedBox(height: 8),
                        Container(
                            width: 50.w,
                            height: 10.h,
                            color: ColorManager(context).grey2),
                      ],
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
