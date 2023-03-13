import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:youtube/data/models/videos_details/videos_details.dart';
import 'package:get/get.dart';
import 'package:youtube/core/resources/color_manager.dart';
import 'package:youtube/core/resources/styles_manager.dart';
import 'package:youtube/data/models/videos_details/video_details_extension.dart';
import 'package:youtube/presentation/common_widgets/circular_profile_image.dart';
import 'package:youtube/presentation/common_widgets/custom_network_display.dart';
import 'package:youtube/presentation/custom_packages/pod_player/src/controllers/pod_player_controller.dart';
import 'package:youtube/presentation/custom_packages/pod_player/src/models/play_video_from.dart';
import 'package:youtube/presentation/custom_packages/pod_player/src/pod_player.dart';
import 'package:youtube/presentation/layouts/base_layout_logic.dart';
import 'package:youtube/presentation/pages/shorts/logic/shorts_page_logic.dart';

part 'horizontal_short_widgets.dart';
part 'vertical_short_widgets.dart';
part 'short_player.dart';

class ShortsPageView extends StatelessWidget {
  const ShortsPageView(this.videoDetailsItem, {super.key});
  final List<VideoDetailsItem>? videoDetailsItem;
  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      scrollDirection: Axis.vertical,
      itemCount: videoDetailsItem?.length ?? 0,
      itemBuilder: (context, index) {
        return Stack(children: [
          SizedBox(
              height: double.infinity,
              child: _ShortPlayer(videoDetailsItem![index])),
          _HorizontalButtons(videoDetailsItem![index]),
          _VerticalButtons(videoDetailsItem![index]),
        ]);
      },
    );
  }
}
