import 'dart:math';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:youtube/core/functions/reformat/date_reformat.dart';
import 'package:youtube/core/functions/reformat/views_reformat.dart';
import 'package:youtube/data/models/video_details/video_details.dart';

class MiniVideoViewLogic extends GetxController {
  final Rx<VideoDetailsItem?> _selectedVideoDetails = Rxn<VideoDetailsItem?>();
  final RxDouble _percentageOFMiniPage = 0.0.obs;
  final RxDouble _heightOFMiniPage = 50.0.obs;
  final RxString _channelTitle = "".obs;
  final RxString _viewCount = "".obs;
  final RxString _dateOfVideo = "".obs;
  final RxString _videoTitle = "".obs;
  final RxString _videoDuration = "".obs;

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
    _channelTitle.value = selectedVideoDetails?.snippet?.channelTitle ?? "";
    _videoTitle.value = selectedVideoDetails?.snippet?.title ?? "";

    DateTime? dateInUtc = selectedVideoDetails?.snippet?.publishedAt;
    _dateOfVideo.value = DateReformat.oneDigitFormat(dateInUtc);

    String views = selectedVideoDetails?.statistics.viewCount ?? "";
    _viewCount.value = CountsReformat.basicViewsFormat(views);

    String duration = selectedVideoDetails?.contentDetails.duration ?? "";
    _videoDuration.value= CountsReformat.videoDurationFormat(duration);
  }

  set percentageOFMiniPage(double value) => _percentageOFMiniPage.value = value;
  set heightOFMiniPage(double value) => _heightOFMiniPage.value = value;

  VideoDetailsItem? get selectedVideoDetails => _selectedVideoDetails.value;
  double get percentageOFMiniPage => _percentageOFMiniPage.value;
  double get heightOFMiniPage => _heightOFMiniPage.value;
  String get channelTitle => _channelTitle.value;
  String get viewCount => _viewCount.value;
  String get dateOfVideo => _dateOfVideo.value;
  String get videoTitle => _videoTitle.value;

  String get videoDuration => _videoDuration.value;
}
