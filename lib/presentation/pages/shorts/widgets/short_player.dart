part of 'shorts_page_view.dart';

class _ShortPlayer extends StatefulWidget {
  const _ShortPlayer(this.videoDetailsItem, {Key? key}) : super(key: key);
  final VideoDetailsItem videoDetailsItem;
  @override
  State<_ShortPlayer> createState() => _ShortPlayerState();
}

class _ShortPlayerState extends State<_ShortPlayer> {
  final ValueNotifier<VideoPlayerController?> videoController =
      ValueNotifier(null);
  final ValueNotifier<Widget> videoStatusAnimation =
      ValueNotifier(const SizedBox());
  final baseLayoutLogic = Get.find<BaseLayoutLogic>(tag: "1");
  List<VideoQalityUrls> vimeoOrVideoUrls = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await initializeVideo(widget.videoDetailsItem);
    });
  }

  Future<void> initializeVideo(VideoDetailsItem videoDetailsItem) async {
    String videoId = videoDetailsItem.id ?? "";

    String videoUrl = 'https://youtu.be/$videoId';

    if (videoController.value?.value.isInitialized ?? false) return;

    final urls = await getVideoQualityUrlsFromYoutube(videoUrl, false);
    final url = getUrlFromVideoQualityUrls(
      qualityList: [1080, 720, 360],
      videoUrls: urls,
    );

    videoController.value = VideoPlayerController.network(url)
      ..setLooping(true)
      ..initialize().then((_) => videoController.value!.play());

    baseLayoutLogic.isShortsInitialize = true;
  }

  Future<List<VideoQalityUrls>> getVideoQualityUrlsFromYoutube(
    String youtubeIdOrUrl,
    bool live,
  ) async {
    return await VideoApis.getYoutubeVideoQualityUrls(youtubeIdOrUrl, live) ??
        [];
  }

  String getUrlFromVideoQualityUrls({
    required List<int> qualityList,
    required List<VideoQalityUrls> videoUrls,
  }) {
    sortQualityVideoUrls(videoUrls);
    if (vimeoOrVideoUrls.isEmpty) {
      throw Exception('videoQuality cannot be empty');
    }

    final fallback = vimeoOrVideoUrls[0];
    VideoQalityUrls? urlWithQuality;
    for (final quality in qualityList) {
      urlWithQuality = vimeoOrVideoUrls.firstWhere(
        (url) => url.quality == quality,
        orElse: () => fallback,
      );

      if (urlWithQuality != fallback) {
        break;
      }
    }

    urlWithQuality ??= fallback;
    return urlWithQuality.url;
  }

  void sortQualityVideoUrls(List<VideoQalityUrls>? inputUrls) {
    final urls = inputUrls;

    ///has issues with 240p
    urls?.removeWhere((element) => element.quality == 240);

    ///has issues with 144p in web
    if (kIsWeb) {
      urls?.removeWhere((element) => element.quality == 144);
    }

    ///sort
    urls?.sort((a, b) => a.quality.compareTo(b.quality));

    ///
    vimeoOrVideoUrls = urls ?? [];
  }

  @override
  void dispose() {
    videoController.dispose();
    videoStatusAnimation.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ShortsLogic>(
      tag: "1",
      id: "update-shorts-video",
      builder: (controller) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          controller.stopVideo
              ? videoController.value?.pause()
              : videoController.value?.play();
        });
        return Stack(
          children: [
            videoPlayer(),
            ValueListenableBuilder(
              valueListenable: videoStatusAnimation,
              builder: (context, value, child) =>
                  Center(child: videoStatusAnimation.value),
            ),
          ],
        );
      },
    );
  }

  Widget videoPlayer() {
    return GestureDetector(
      onTap: onTapVideo,
      onLongPressStart: (LongPressStartDetails event) {
        if (!(videoController.value?.value.isInitialized ?? false)) return;

        videoController.value!.pause();
      },
      onLongPressEnd: (LongPressEndDetails event) {
        if (!(videoController.value?.value.isInitialized ?? false)) return;

        videoController.value!.play();
      },
      child: ValueListenableBuilder(
        valueListenable: videoController,
        builder: (context, VideoPlayerController? controller, child) {
          if (controller == null) {
            return const ThineCircularProgress(color: BaseColorManager.white);
          } else {
            return AnimatedBuilder(
              animation: controller,
              builder: (context, child) => VideoPlayer(controller),
            );
          }
        },
      ),
    );
  }

  void onTapVideo() {
    if (videoController.value?.value.isInitialized ?? false) return;

    if (!videoController.value!.value.isPlaying) {
      videoStatusAnimation.value = const _FadeAnimation(
          child: _VolumeContainer(Icons.play_arrow_rounded));
      videoController.value?.play();
    } else {
      videoStatusAnimation.value =
          const _FadeAnimation(child: _VolumeContainer(Icons.pause));
      videoController.value?.pause();
    }
  }
}

class _VolumeContainer extends StatelessWidget {
  const _VolumeContainer(this.icon, {Key? key}) : super(key: key);
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(40),
          color: BaseColorManager.black87),
      padding: const EdgeInsetsDirectional.all(15),
      child: Icon(
        icon,
        size: 35.0,
        color: BaseColorManager.white,
      ),
    );
  }
}

class _FadeAnimation extends StatefulWidget {
  const _FadeAnimation({Key? key, required this.child}) : super(key: key);

  final Widget child;

  @override
  _FadeAnimationState createState() => _FadeAnimationState();
}

class _FadeAnimationState extends State<_FadeAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
        duration: const Duration(milliseconds: 1500), vsync: this);
    animationController.forward(from: 0.0);
  }

  @override
  void deactivate() {
    animationController.stop();

    super.deactivate();
  }

  @override
  void didUpdateWidget(_FadeAnimation oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.child != widget.child) {
      animationController.forward(from: 0.0);
    }
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => animationController.isAnimating
      ? AnimatedBuilder(
          animation: animationController,
          builder: (context, child) => AnimatedOpacity(
            opacity: 1.0 - animationController.value,
            duration: const Duration(milliseconds: 10),
            child: widget.child,
          ),
        )
      : const SizedBox();
}
