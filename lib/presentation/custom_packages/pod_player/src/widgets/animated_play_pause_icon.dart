import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:youtube/presentation/custom_packages/pod_player/src/controllers/pod_getx_video_controller.dart';
import 'package:youtube/presentation/custom_packages/pod_player/src/utils/enums.dart';
import 'package:youtube/presentation/custom_packages/pod_player/src/widgets/material_icon_button.dart';

class AnimatedPlayPauseIcon extends StatefulWidget {
  final double? size;
  final String tag;

  const AnimatedPlayPauseIcon({
    Key? key,
    this.size,
    required this.tag,
  }) : super(key: key);

  @override
  State<AnimatedPlayPauseIcon> createState() => AnimatedPlayPauseIconState();
}

class AnimatedPlayPauseIconState extends State<AnimatedPlayPauseIcon>
    with SingleTickerProviderStateMixin {
  late final AnimationController _payCtr;
  late PodGetXVideoController podCtr;
  @override
  void initState() {
    podCtr = Get.find<PodGetXVideoController>(tag: widget.tag);
    _payCtr = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 450),
    );
    podCtr.addListenerId('podVideoState', playPauseListner);
    if (podCtr.isvideoPlaying) {
      if (mounted) _payCtr.forward();
    }
    super.initState();
  }

  void playPauseListner() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (podCtr.podVideoState == PodVideoState.playing) {
        if (mounted) _payCtr.forward();
      }
      if (podCtr.podVideoState == PodVideoState.paused) {
        if (mounted) _payCtr.reverse();
      }
    });
  }

  @override
  void dispose() {
    // podLog('Play-pause-controller-disposed');
    _payCtr.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PodGetXVideoController>(
      tag: widget.tag,
      id: 'overlay',
      builder: (podCtr) {
        return GetBuilder<PodGetXVideoController>(
          tag: widget.tag,
          id: 'podVideoState',
          builder: (f) => MaterialIconButton(
            toolTipMesg: f.isvideoPlaying
                ? podCtr.podPlayerLabels.pause ??
                    'Pause${kIsWeb ? ' (space)' : ''}'
                : podCtr.podPlayerLabels.play ??
                    'Play${kIsWeb ? ' (space)' : ''}',
            onPressed:
                podCtr.isOverlayVisible ? podCtr.togglePlayPauseVideo : null,
            child: onStateChange(podCtr),
          ),
        );
      },
    );
  }

  Widget onStateChange(PodGetXVideoController podCtr) {
    if (kIsWeb) return _playPause(podCtr);
    if (podCtr.podVideoState == PodVideoState.loading) {
      return const SizedBox();
    } else {
      return _playPause(podCtr);
    }
  }

  Widget _playPause(PodGetXVideoController _) {
    return AnimatedIcon(
      icon: AnimatedIcons.play_pause,
      progress: _payCtr,
      color: Colors.white,
      size: widget.size,
    );
  }
}
