import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:youtube/core/resources/color_manager.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SliverHorizontalVideosShimmerLoading extends StatelessWidget {
  const SliverHorizontalVideosShimmerLoading(
      {this.forTwoTexts = false,
      this.heightOfImage = 80,
      this.widthOfImage = 160,
      this.withoutTopPaddingInFirstIndex = false,
      this.borderRadius = 10,
      super.key});
  final bool forTwoTexts;
  final double heightOfImage;
  final double widthOfImage;
  final double  borderRadius;
  final bool withoutTopPaddingInFirstIndex;
  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        childCount: 20,
        (context, index) => Shimmer.fromColors(
          baseColor: ColorManager(context).grey1,
          highlightColor: ColorManager(context).greyPoint5,
          child: Padding(
            padding: REdgeInsetsDirectional.only(start: 15, top:withoutTopPaddingInFirstIndex&&index==0?0: 15),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(borderRadius.r),
                  child: Container(
                    height: heightOfImage.h,
                    width: widthOfImage.w,
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
                      if (!forTwoTexts) ...[
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
