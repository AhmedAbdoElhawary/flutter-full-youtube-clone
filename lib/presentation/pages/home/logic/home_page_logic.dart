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
  PodPlayerController? floatingVideoController;

  final RxBool _moveThumbnailVideo = true.obs;
  final RxBool _showFloatingVideo = false.obs;
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
    setSelectedVideoDetails = videoDetailsItem;

    String videoId = videoDetailsItem?.id ?? "";
    String url = getUrl(videoId);

    stateOfMiniPlayer();

    if (floatingVideoController?.videoUrl == url) return;

    if (floatingVideoController?.isInitialised ?? false) {
      _changeController(videoId);
    } else {
      _firstInitialized(videoId);
    }
  }

  String getUrl(String videoId) => 'https://youtu.be/$videoId';

  Future<void> _changeController(String videoId) async {
    if (videoId.isNotEmpty && floatingVideoController != null) {
      await floatingVideoController?.changeVideo(
        playVideoFrom: getPlayVideoFrom(videoId),
        playVideoDirectly: false,
      );

      _addVideoListener();
    }
  }

  void stateOfMiniPlayer({bool extendHeight = true}) {
    miniPlayerController.animateToHeight(
        height: extendHeight ? maxHeight : minHeight,
        duration: const Duration(milliseconds: 300));
  }

  void _firstInitialized(String videoId) {
    floatingVideoController = PodPlayerController(
      playVideoFrom: getPlayVideoFrom(videoId),
      getTag: "mini",
    )..initialise();

    _addVideoListener();
  }

  PlayVideoFrom getPlayVideoFrom(String videoId) =>
      PlayVideoFrom.youtube(getUrl(videoId));

  void _addVideoListener() {
    floatingVideoController!.addListener(controlListener);
  }

  void controlListener() {
    if (percentageOFMiniPage <= 0.4) {
      _isMiniVideoPlaying.value =
          floatingVideoController?.isVideoPlaying ?? true;
      getDurationVideoValue();
      update(["update-mini-player"]);
    }
  }

  double getDurationVideoValue() {
    VideoPlayerValue? videoPlayerValue =
        floatingVideoController?.videoPlayerValue;
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

  set heightOFMiniPage(double value) => _heightOFMiniPage.value = value;

  set selectedVideoRating(String value) {
    _selectedVideoRating.value = value;
    update(["update-video-rating"]);
  }

  set setSelectedVideoDetails(VideoDetailsItem? value) {
    _selectedVideoDetails.value = value;
    showFloatingVideo = value != null;
    moveThumbnailVideo = value == null;
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
  }

  bool get showFloatingVideo => _showFloatingVideo.value;

  set showFloatingVideo(bool value) {
    _showFloatingVideo.value = value;
    floatingVideoController?.pause();
    update(["update-selected-video"]);
  }

  String get selectedVideoRating => _selectedVideoRating.value;
  bool get isMiniVideoPlaying => _isMiniVideoPlaying.value;
  double get percentageOFMiniPage => _percentageOFMiniPage.value;
  double get heightOFMiniPage => _heightOFMiniPage.value;

  VideoDetailsItem? get getSelectedVideoDetails => _selectedVideoDetails.value;

  double get minHeight => _minHeight;
  double get maxHeight => _height;
}
