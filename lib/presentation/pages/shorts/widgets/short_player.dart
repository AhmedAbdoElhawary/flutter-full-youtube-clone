part of '../shorts_page.dart';

class _ShortPlayer extends StatefulWidget {
  const _ShortPlayer({Key? key}) : super(key: key);

  @override
  State<_ShortPlayer> createState() => _ShortPlayerState();
}

class _ShortPlayerState extends State<_ShortPlayer> {
  final logic = Get.find<ShortsLogic>(tag: "1");

  @override
  void initState() {
    super.initState();
    logic.controller = VideoPlayerController.network(
        "https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4")
      ..setLooping(true)
      ..initialize().then((_) => logic.controller.play());
    logic.initializeVideoPlayerFuture = logic.controller.initialize();

  }

  @override
  void dispose() {
    logic.controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ShortsLogic>(
      id: "update current short",
      tag: "1",
      builder: (logic) {
        return Stack(
          children: [
            GestureDetector(
              onTap: onTapVideo,
              child: FutureBuilder(
                future: logic.initializeVideoPlayerFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return AnimatedBuilder(
                      animation: logic.controller,
                      builder: (context, child) =>
                          VideoPlayer(logic.controller),
                    );
                  } else {
                    return const ThineCircularProgress(
                        color: BaseColorManager.white);
                  }
                },
              ),
            ),
            Center(child: logic.videoStatusAnimation),
          ],
        );
      },
    );
  }

  void onTapVideo() {
    if (!logic.controller.value.isInitialized) return;

    if (!logic.controller.value.isPlaying) {
      logic.videoStatusAnimation = const _FadeAnimation(
          child: _VolumeContainer(Icons.play_arrow_rounded));
      logic.controller.play();
    } else {
      logic.videoStatusAnimation =
          const _FadeAnimation(child: _VolumeContainer(Icons.pause));
      logic.controller.pause();
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
          color: ColorManager(context).black87),
      padding: const EdgeInsetsDirectional.all(25),
      child: Icon(
        icon,
        size: 23.0,
        color: ColorManager(context).white,
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
