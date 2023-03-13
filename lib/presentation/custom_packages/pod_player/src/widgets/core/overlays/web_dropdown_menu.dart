import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:youtube/core/resources/color_manager.dart';
import 'package:youtube/presentation/custom_packages/pod_player/src/controllers/pod_getx_video_controller.dart';
import 'package:youtube/presentation/custom_packages/pod_player/src/widgets/material_icon_button.dart';

class WebSettingsDropdown extends StatefulWidget {
  final String tag;

  const WebSettingsDropdown({
    Key? key,
    required this.tag,
  }) : super(key: key);

  @override
  State<WebSettingsDropdown> createState() => WebSettingsDropdownState();
}

class WebSettingsDropdownState extends State<WebSettingsDropdown> {
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        focusColor: Colors.white,
      ),
      child: GetBuilder<PodGetXVideoController>(
        tag: widget.tag,
        builder: (podCtr) {
          return MaterialIconButton(
            toolTipMsg: podCtr.podPlayerLabels.settings,
            color: Colors.white,
            child: const Icon(Icons.settings, color: BaseColorManager.white),
            onPressed: () => podCtr.isFullScreen
                ? podCtr.isWebPopupOverlayOpen = true
                : podCtr.isWebPopupOverlayOpen = false,
            onTapDown: (details) async {
              final settingsMenu = await showMenu<String>(
                context: context,
                items: [
                  if (podCtr.vimeoOrVideoUrls.isNotEmpty)
                    PopupMenuItem(
                      value: 'OUALITY',
                      child: _bottomSheetTiles(
                        title: podCtr.podPlayerLabels.quality,
                        icon: Icons.video_settings_rounded,
                        subText: '${podCtr.vimeoPlayingVideoQuality}p',
                      ),
                    ),
                  PopupMenuItem(
                    value: 'LOOP',
                    child: _bottomSheetTiles(
                      title: podCtr.podPlayerLabels.loopVideo,
                      icon: Icons.loop_rounded,
                      subText: podCtr.isLooping
                          ? podCtr.podPlayerLabels.optionEnabled
                          : podCtr.podPlayerLabels.optionDisabled,
                    ),
                  ),
                  PopupMenuItem(
                    value: 'SPEED',
                    child: _bottomSheetTiles(
                      title: podCtr.podPlayerLabels.playbackSpeed,
                      icon: Icons.slow_motion_video_rounded,
                      subText: podCtr.currentPaybackSpeed,
                    ),
                  ),
                ],
                position: RelativeRect.fromSize(
                  details.globalPosition & Size.zero,
                  MediaQuery.of(context).size,
                ),
              );
              switch (settingsMenu) {
                case 'OUALITY':
                  await _onVimeoQualitySelect(details, podCtr);
                  break;
                case 'SPEED':
                  await _onPlaybackSpeedSelect(details, podCtr);
                  break;
                case 'LOOP':
                  podCtr.isWebPopupOverlayOpen = false;
                  await podCtr.toggleLooping();
                  break;
                default:
                  podCtr.isWebPopupOverlayOpen = false;
              }
            },
          );
        },
      ),
    );
  }

  Future<void> _onPlaybackSpeedSelect(
    TapDownDetails details,
    PodGetXVideoController podCtr,
  ) async {
    await Future.delayed(
      const Duration(milliseconds: 400),
    );
    if (context.mounted) return;

    await showMenu(
      context: context,
      items: podCtr.videoPlaybackSpeeds
          .map(
            (e) => PopupMenuItem(
              child: ListTile(
                title: Text(e),
              ),
              onTap: () {
                podCtr.setVideoPlayBack(e);
              },
            ),
          )
          .toList(),
      position: RelativeRect.fromSize(
        details.globalPosition & Size.zero,
        // ignore: use_build_context_synchronously
        MediaQuery.of(context).size,
      ),
    );
    podCtr.isWebPopupOverlayOpen = false;
  }

  Future<void> _onVimeoQualitySelect(
    TapDownDetails details,
    PodGetXVideoController podCtr,
  ) async {
    await Future.delayed(
      const Duration(milliseconds: 400),
    );
    if (context.mounted) return;
    await showMenu(
      context: context,
      items: podCtr.vimeoOrVideoUrls
          .map(
            (e) => PopupMenuItem(
              child: ListTile(
                title: Text('${e.quality}p'),
              ),
              onTap: () {
                podCtr.changeVideoQuality(
                  e.quality,
                );
              },
            ),
          )
          .toList(),
      position: RelativeRect.fromSize(
        details.globalPosition & Size.zero,
        // ignore: use_build_context_synchronously
        MediaQuery.of(context).size,
      ),
    );
    podCtr.isWebPopupOverlayOpen = false;
  }

  Widget _bottomSheetTiles({
    required String title,
    required IconData icon,
    String? subText,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: FittedBox(
        fit: BoxFit.scaleDown,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon),
            const SizedBox(width: 20),
            Text(
              title,
            ),
            if (subText != null) const SizedBox(width: 10),
            if (subText != null)
              const SizedBox(
                height: 4,
                width: 4,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            if (subText != null) const SizedBox(width: 6),
            if (subText != null)
              Text(
                subText,
                style: const TextStyle(color: Colors.grey),
              ),
          ],
        ),
      ),
    );
  }
}
