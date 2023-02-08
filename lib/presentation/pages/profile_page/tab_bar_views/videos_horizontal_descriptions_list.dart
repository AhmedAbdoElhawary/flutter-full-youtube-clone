import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/resources/assets_manager.dart';
import '../../../../core/resources/color_manager.dart';
import '../../../../core/resources/styles_manager.dart';

class VideoHorizontalDescriptionsList extends StatelessWidget {
  const VideoHorizontalDescriptionsList({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
            width: 160.w, height: 80.h, color: ColorManager(context).grey2),
        const RSizedBox(width: 15),
        Flexible(
          child: Column(
            children: [
              Text(
                "تجربتي في تعلم البرمجه من الصفر بدون الحصول علي شهاده في علوم الكمبيوتر",
                overflow: TextOverflow.ellipsis,
                maxLines: 3,
                style: getNormalStyle(
                    color: ColorManager(context).black, fontSize: 14),
              ),
              const RSizedBox(height: 3),
              Text(
                "884k views . 2 weeks ago",
                style: getNormalStyle(
                    color: ColorManager(context).grey7, fontSize: 12),
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
            ],
          ),
        ),
        Padding(
          padding:  REdgeInsetsDirectional.only(start: 10,end: 15),
          child: SvgPicture.asset(IconsAssets.menuPointsVerticalIcon,height: 12),
        ),
      ],
    );
  }
}
