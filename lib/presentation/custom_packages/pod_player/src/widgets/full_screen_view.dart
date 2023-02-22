import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:youtube/presentation/custom_packages/pod_player/src/controllers/pod_getx_video_controller.dart';
import 'package:youtube/presentation/custom_packages/pod_player/src/widgets/core/pod_core_player.dart';

class FullScreenView extends StatefulWidget {
  final String tag;
  const FullScreenView({
    Key? key,
    required this.tag,
  }) : super(key: key);

  @override
  State<FullScreenView> createState() => _FullScreenViewState();
}

class _FullScreenViewState extends State<FullScreenView>
    with TickerProviderStateMixin {
  late PodGetXVideoController podCtr;
  @override
  void initState() {
    podCtr = Get.find<PodGetXVideoController>(tag: widget.tag);
    podCtr.fullScreenContext = context;
    podCtr.keyboardFocusWeb?.removeListener(podCtr.keyboadListner);

    super.initState();
  }

  @override
  void dispose() {
    podCtr.keyboardFocusWeb?.requestFocus();
    podCtr.keyboardFocusWeb?.addListener(podCtr.keyboadListner);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final loadingWidget = podCtr.onLoading?.call(context) ??
        const CircularProgressIndicator(
          backgroundColor: Colors.black87,
          color: Colors.white,
          strokeWidth: 2,
        );

    return WillPopScope(
      onWillPop: () async {
        if (kIsWeb) {
          await podCtr.disableFullScreen(
            context,
            widget.tag,
            enablePop: false,
          );
        }
        if (context.mounted) return true;

        if (!kIsWeb) await podCtr.disableFullScreen(context, widget.tag);
        return true;
      },
      child: Scaffold(
        backgroundColor: Colors.black,
        body: GetBuilder<PodGetXVideoController>(
          tag: widget.tag,
          builder: (podCtr) => Center(
            child: ColoredBox(
              color: Colors.black,
              child: SizedBox(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Center(
                  child: podCtr.videoCtr == null
                      ? loadingWidget
                      : podCtr.videoCtr!.value.isInitialized
                          ? PodCoreVideoPlayer(
                              tag: widget.tag,
                              videoPlayerCtr: podCtr.videoCtr!,
                              videoAspectRatio:
                                  podCtr.videoCtr?.value.aspectRatio ?? 16 / 9,
                            )
                          : loadingWidget,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
