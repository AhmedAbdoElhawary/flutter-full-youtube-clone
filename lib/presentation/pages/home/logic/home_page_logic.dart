import 'dart:math';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:youtube/data/models/video_details/video_details.dart';

class MiniVideoViewLogic extends GetxController {
  final Rx<VideoDetailsItem?> videoDetailsItem = Rxn<VideoDetailsItem?>();

  final RxDouble percentageOFMiniPage = 0.0.obs;
  final RxDouble heightOFMiniPage = 50.0.obs;

  double videoOfMiniDisplayWidth(double screenWidth) {
    double basicWidth = (screenWidth * percentageOFMiniPage.value * 12) + 130.w;
    return min(basicWidth, screenWidth);
  }

  double videoOfMiniDisplayHeight() {
    double newHeight = 48.h + (heightOFMiniPage.value - 50.h);
    double secondHeight = max(percentageOFMiniPage.value * 185.h, 90.h);
    double height =
        percentageOFMiniPage.value <= 0.05 ? newHeight : secondHeight;
    return height;
  }
}
