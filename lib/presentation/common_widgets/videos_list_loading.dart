import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:youtube/core/resources/color_manager.dart';
import 'package:youtube/presentation/common_widgets/container_loading.dart';

class VideosListLoading extends StatelessWidget {
  const VideosListLoading({this.neverScroll = false, super.key});
  final bool neverScroll;
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        shrinkWrap: neverScroll,
        physics: neverScroll ? const NeverScrollableScrollPhysics() : null,
        itemBuilder: (context, index) => Column(
              children: [
                Container(
                    height: 185.h,
                    width: double.infinity,
                    color: ColorManager(context).grey1),
                Padding(
                  padding: REdgeInsets.all(10.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(
                          radius: 20,
                          backgroundColor: ColorManager(context).grey1),
                      const RSizedBox(width: 10),
                      Flexible(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            ContainerLoading(radius: 2, noPadding: true),
                            RSizedBox(height: 10),
                            ContainerLoading(radius: 2, noPadding: true),
                            RSizedBox(height: 10),
                            ContainerLoading(
                                width: 150, radius: 2, noPadding: true),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
        separatorBuilder: (context, index) => const RSizedBox(height: 15),
        itemCount: 10);
  }
}
