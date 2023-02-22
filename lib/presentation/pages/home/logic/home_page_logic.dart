import 'dart:math';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:youtube/data/models/videos_details/videos_details.dart';

class MiniVideoViewLogic extends GetxController {
  final Rx<VideoDetailsItem?> _selectedVideoDetails = Rxn<VideoDetailsItem?>();

  final RxDouble _percentageOFMiniPage = 0.0.obs;
  final RxDouble _heightOFMiniPage = 50.0.obs;

  double videoOfMiniDisplayWidth(double screenWidth) {
    double basicWidth = (screenWidth * percentageOFMiniPage * 12) + 130.w;
    return min(basicWidth, screenWidth);
  }

  double videoOfMiniDisplayHeight() {
    double newHeight = 48.h + (heightOFMiniPage - 50.h);
    double secondHeight = max(percentageOFMiniPage * 185.h, 90.h);
    double height = percentageOFMiniPage <= 0.05 ? newHeight : secondHeight;
    return height;
  }

  set selectedVideoDetails(VideoDetailsItem? value) {
    _selectedVideoDetails.value = value;
  }

  set percentageOFMiniPage(double value) => _percentageOFMiniPage.value = value;
  set heightOFMiniPage(double value) => _heightOFMiniPage.value = value;

  double get percentageOFMiniPage => _percentageOFMiniPage.value;
  double get heightOFMiniPage => _heightOFMiniPage.value;

  VideoDetailsItem? get selectedVideoDetails => _selectedVideoDetails.value;

}
