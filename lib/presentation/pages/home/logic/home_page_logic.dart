import 'dart:math';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:youtube/core/utility/constants.dart';
import 'package:youtube/data/models/videos_details/videos_details.dart';
import 'package:youtube/presentation/custom_packages/custom_mini_player/custom_mini_player.dart';
import 'package:youtube/presentation/custom_packages/pod_player/pod_player.dart';

class MiniVideoViewLogic extends GetxController {
  final Rx<VideoDetailsItem?> _selectedVideoDetails = Rxn<VideoDetailsItem?>();
  final Rx<String> _selectedVideoRating = "none".obs;
  PodPlayerController? videoController;
  PodPlayerController? thumbnailVideoController;
  MiniPlayerController miniPlayerController = MiniPlayerController();
  final RxDouble _percentageOFMiniPage = 0.0.obs;
  final RxDouble _heightOFMiniPage = 50.0.obs;
  final RxDouble heightOfNavigationBar = 44.0.obs;
  final double _minHeight = 50.h;
  final double _height = screenSize.height - 10.h;
  final RxBool isMiniVideoInitialized = false.obs;
  final RxBool _isMiniVideoPlaying = false.obs;

  void initializeVideoController(
      {VideoDetailsItem? videoDetailsItem, bool isThatThumbnailVideo = false}) {
    selectedVideoDetails = videoDetailsItem;
    String videoId = videoDetailsItem?.id ?? "";

    thumbnailVideoController?.pause();

    if (videoController?.videoUrl == _url(videoId)) return;

    if (videoController?.isInitialised ?? false) {
      _changeController(videoId);
    } else {
      _firstInitialized(videoId);
    }
  }

  Future<void> _changeController(String videoId) async {
    if (videoId.isNotEmpty && videoController != null) {
      await videoController?.changeVideo(
        playVideoFrom: getPlayVideoFrom(videoId),
        playVideoDirectly: false,
      );

      _addVideoListener();
    }
  }

  void _firstInitialized(String videoId) {
    videoController = PodPlayerController(
      playVideoFrom: getPlayVideoFrom(videoId),
      getTag: "mini",
    )..initialise();

    _addVideoListener();
  }

  static PlayVideoFrom getPlayVideoFrom(String videoId) =>
      PlayVideoFrom.youtube(_url(videoId));

  static String _url(String videoId) => 'https://youtu.be/$videoId';

  void _addVideoListener() {
    videoController!.addListener(() {
      if (percentageOFMiniPage <= 0.4) {
        _isMiniVideoPlaying.value = videoController?.isVideoPlaying ?? true;
        getDurationVideoValue();
        update(["update mini player"]);
      }
    });
  }

  double getDurationVideoValue() {
    VideoPlayerValue? videoPlayerValue = videoController?.videoPlayerValue;
    int totalDuration = videoPlayerValue?.duration.inSeconds ?? 1;
    int currentValue = videoPlayerValue?.position.inSeconds ?? 0;
    double durationValue = (currentValue / totalDuration);
    return durationValue;
  }

  double videoOfMiniDisplayWidth(double screenWidth) {
    double basicWidth = (screenWidth * percentageOFMiniPage * 12) + 130.w;
    return min(basicWidth, screenWidth);
  }

  double videoOfMiniDisplayHeight(
      {required double screenHeight, required double percentage}) {
    double newHeight = 48.h + (screenHeight - 50.h);
    double secondHeight = max(percentage * 185.h, 90.h);
    double height = percentage <= 0.05 ? newHeight : secondHeight;
    return height;
  }

  bool get isMiniVideoPlaying => _isMiniVideoPlaying.value;

  set isMiniVideoPlaying(bool value) => _isMiniVideoPlaying.value = value;

  String get selectedVideoRating => _selectedVideoRating.value;

  set selectedVideoRating(String value) => _selectedVideoRating.value = value;

  set selectedVideoDetails(VideoDetailsItem? value) =>
      _selectedVideoDetails.value = value;

  set percentageOFMiniPage(double value) {
    _percentageOFMiniPage.value = value;

    heightOfNavigationBar.value = (1 - value) * 44;
  }

  set heightOFMiniPage(double value) => _heightOFMiniPage.value = value;

  double get percentageOFMiniPage => _percentageOFMiniPage.value;
  double get heightOFMiniPage => _heightOFMiniPage.value;

  VideoDetailsItem? get selectedVideoDetails => _selectedVideoDetails.value;

  double get minHeight => _minHeight;
  double get maxHeight => _height;
}
