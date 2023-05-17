import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:youtube/core/helpers/reformat/views_reformat.dart';
import 'package:youtube/data/models/videos_details/videos_details.dart';

import '../../core/resources/color_manager.dart';
import '../../core/resources/styles_manager.dart';

class VideoDurationWidget extends StatelessWidget {
  const VideoDurationWidget(this.videoDetailsItem, {super.key});
  final VideoDetailsItem? videoDetailsItem;

  @override
  Widget build(BuildContext context) {
    String duration = videoDetailsItem?.contentDetails.duration ?? "";
    String durationReformat = CountsReformat.videoDurationFormat(duration);
    return Padding(
      padding: REdgeInsets.all(8.0),
      child: Container(
        padding: REdgeInsets.symmetric(horizontal: 2, vertical: 1.5),
        decoration: BoxDecoration(
            color: BaseColorManager.black87,
            borderRadius: BorderRadius.circular(2)),
        child: Text(
          durationReformat,
          style:
          getMediumStyle(color:BaseColorManager.white, fontSize: 12),
        ),
      ),
    );
  }
}
