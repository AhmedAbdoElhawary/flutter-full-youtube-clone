import 'dart:math';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:youtube/core/utility/constants.dart';
import 'package:youtube/data/models/videos_details/videos_details.dart';
import 'package:youtube/presentation/custom_packages/custom_mini_player/custom_mini_player.dart';
import 'package:youtube/presentation/custom_packages/pod_player/pod_player.dart';

class MiniVideoViewLogic extends GetxController {
  final Rx<VideoDetailsItem?> _selectedVideoDetails = Rxn<VideoDetailsItem?>();
  final Rx<VideoDetailsItem?> _selectedMovedVideoDetails =
      Rxn<VideoDetailsItem?>();
  final Rx<String> _selectedVideoRating = "none".obs;
  PodPlayerController? videoController;

  final RxBool _moveThumbnailVideo = true.obs;
  MiniPlayerController miniPlayerController = MiniPlayerController();
  final RxDouble _percentageOFMiniPage = 0.0.obs;
  final RxDouble _heightOFMiniPage = 50.0.obs;
  final RxDouble heightOfNavigationBar = 44.0.obs;
  final double _minHeight = 50.h;
  final double _height = screenSize.height - 10.h;
  final RxBool isMiniVideoInitialized = false.obs;
  final RxBool _isMiniVideoPlaying = false.obs;
  final RxBool _stopThumbnailVideo = false.obs;

  void initializeVideoController(
      {VideoDetailsItem? videoDetailsItem, bool isThatThumbnailVideo = false}) {
    setSelectedVideoDetails = videoDetailsItem;

    String videoId = videoDetailsItem?.id ?? "";
    String url = getUrl(videoId);

    miniPlayerController.animateToHeight(
        height: maxHeight, duration: const Duration(milliseconds: 300));

    if (videoController?.videoUrl == url) return;

    if (videoController?.isInitialised ?? false) {
      _changeController(videoId);
    } else {
      _firstInitialized(videoId);
    }
  }

  String getUrl(String videoId) => 'https://youtu.be/$videoId';

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

  PlayVideoFrom getPlayVideoFrom(String videoId) =>
      PlayVideoFrom.youtube(getUrl(videoId));

  void _addVideoListener() {
    videoController!.addListener(controlListener);
  }

  void controlListener() {
    if (percentageOFMiniPage <= 0.4) {
      _isMiniVideoPlaying.value = videoController?.isVideoPlaying ?? true;
      getDurationVideoValue();
      update(["update-mini-player"]);
    }
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

  double videoOfMiniDisplayHeight() {
    double newHeight = 48.h + (heightOFMiniPage - 50.h);
    double secondHeight = max(percentageOFMiniPage * 185.h, 90.h);
    double height = percentageOFMiniPage <= 0.05 ? newHeight : secondHeight;
    return height;
  }

  set isMiniVideoPlaying(bool value) => _isMiniVideoPlaying.value = value;

  set stopThumbnailVideo(bool value) {
    _stopThumbnailVideo.value = value;
  }

  set heightOFMiniPage(double value) => _heightOFMiniPage.value = value;

  set selectedVideoRating(String value) {
    _selectedVideoRating.value = value;
    update(["update-video-rating"]);
  }

  void updateSelectedVideo(){
    update(["update-selected-video"]);
  }

  set setSelectedVideoDetails(VideoDetailsItem? value) {
    _selectedVideoDetails.value = value;
    update(["update-selected-video"]);
  }

  set percentageOFMiniPage(double value) {
    _percentageOFMiniPage.value = value;

    heightOfNavigationBar.value = (1 - value) * 44;
    update(["update-mini-player"]);
  }

  bool get moveThumbnailVideo => _moveThumbnailVideo.value;

  set moveThumbnailVideo(bool value) {
    _moveThumbnailVideo.value = value;
    update(["update-selected-video"]);
  }

  VideoDetailsItem? get selectedMovedVideoDetails =>
      _selectedMovedVideoDetails.value;

  set selectedMovedVideoDetails(VideoDetailsItem? value) {
    _selectedMovedVideoDetails.value = value;
    // update(["update-thumbnail-moved-video"]);
  }

  bool get stopThumbnailVideo => _stopThumbnailVideo.value;

  String get selectedVideoRating => _selectedVideoRating.value;
  bool get isMiniVideoPlaying => _isMiniVideoPlaying.value;
  double get percentageOFMiniPage => _percentageOFMiniPage.value;
  double get heightOFMiniPage => _heightOFMiniPage.value;

  VideoDetailsItem? get getSelectedVideoDetails => _selectedVideoDetails.value;

  double get minHeight => _minHeight;
  double get maxHeight => _height;
}
