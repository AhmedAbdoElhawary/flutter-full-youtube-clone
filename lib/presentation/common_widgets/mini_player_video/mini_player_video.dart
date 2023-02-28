import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sliding_sheet/sliding_sheet.dart';
import 'package:youtube/config/routes/route_app.dart';
import 'package:youtube/core/functions/network_exceptions.dart';
import 'package:youtube/core/functions/toast_show.dart';
import 'package:youtube/core/resources/assets_manager.dart';
import 'package:youtube/core/resources/color_manager.dart';
import 'package:youtube/core/resources/styles_manager.dart';
import 'package:youtube/data/models/comment_details/comment_details.dart';
import 'package:youtube/data/models/comment_details/comment_details_extension.dart';
import 'package:youtube/data/models/common/base_comment_snippet/sub_comment_snippet.dart';
import 'package:youtube/data/models/rating_details/rating_details.dart';
import 'package:youtube/data/models/videos_details/video_details_extension.dart';
import 'package:youtube/data/models/videos_details/videos_details.dart';
import 'package:youtube/presentation/common_widgets/circular_profile_image.dart';
import 'package:youtube/presentation/common_widgets/custom_circle_progress.dart';
import 'package:youtube/presentation/common_widgets/read_more_text.dart';
import 'package:youtube/presentation/common_widgets/text_links.dart';
import 'package:youtube/presentation/common_widgets/thumbnail_of_video.dart';
import 'package:youtube/presentation/cubit/search/search_cubit.dart';
import 'package:youtube/presentation/cubit/single_video/single_video_cubit.dart';
import 'package:youtube/presentation/custom_packages/custom_mini_player/custom_mini_player.dart';
import 'package:youtube/presentation/custom_packages/pod_player/src/controllers/pod_player_controller.dart';
import 'package:youtube/presentation/custom_packages/pod_player/src/pod_player.dart';
import 'package:youtube/presentation/pages/home/logic/home_page_logic.dart';
import 'package:youtube/presentation/common_widgets/subscribe_button.dart';

part 'sub_widgets/like_button.dart';
part 'sub_widgets/dislike_button.dart';
part 'sub_widgets/interaction_simmer_loading.dart';
part 'sub_widgets/mini_video_view.dart';
part 'sub_widgets/draggable_bottom_sheet.dart';
part 'sub_widgets/fisrt_comment_preview_button.dart';
part 'sub_widgets/bottom_sheet/description_bottom_sheet.dart';
part 'sub_widgets/bottom_sheet/head_of_bottom_sheet.dart';
part 'sub_widgets/bottom_sheet/comments_bottom_sheet.dart';

class MiniPlayerVideo extends StatefulWidget {
  const MiniPlayerVideo({super.key});

  @override
  State<MiniPlayerVideo> createState() => _MiniPlayerVideoState();
}

class _MiniPlayerVideoState extends State<MiniPlayerVideo> {
  final double minHeight = 50.h;
  final _miniVideoViewLogic = Get.find<MiniVideoViewLogic>(tag: "1");
  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    double height = mediaQuery.size.height - 10.h;
    return SafeArea(
      child: CustomMiniPlayer(
        controller: _miniVideoViewLogic.miniPlayerController,
        minHeight: minHeight,
        maxHeight: height,
        onDismissed: () {
          _miniVideoViewLogic.selectedVideoDetails = null;
        },
        builder: (height, percentage) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            _miniVideoViewLogic.percentageOFMiniPage = percentage;
            _miniVideoViewLogic.heightOFMiniPage = height;
          });

          return _MiniVideoDisplay(height, percentage);
        },
      ),
    );
  }
}

class _MiniVideoDisplay extends StatelessWidget {
  const _MiniVideoDisplay(this.height, this.percentage);
  final double height;
  final double percentage;
  @override
  Widget build(BuildContext context) {
    final miniVideoViewLogic = Get.find<MiniVideoViewLogic>(tag: "1");

    return SafeArea(
      child: Container(
        color: Theme.of(context).primaryColor,
        child: Stack(
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Flexible(
                  child: Padding(
                    padding: EdgeInsets.only(
                        top: miniVideoViewLogic.videoOfMiniDisplayHeight()),
                    child: const NextVideosSuggestions(),
                  ),
                )
              ],
            ),
            _MiniVideoView(height: height, percentage: percentage),
          ],
        ),
      ),
    );
  }
}

class NextVideosSuggestions extends StatelessWidget {
  const NextVideosSuggestions({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final logic = Get.find<MiniVideoViewLogic>(tag: "1");
      String videoId = logic.selectedVideoDetails?.id ?? "";
      return BlocBuilder<SearchCubit, SearchState>(
        bloc: SearchCubit.get(context)..relatedVideosToThisVideo(videoId),
        builder: (context, state) {
          return state.maybeWhen(
              relatedVideosLoaded: (videosDetails) => ListView.separated(
                  itemBuilder: (context, index) {
                    if (index == 0) {
                      return const _VideoInfo();
                    } else {
                      return ThumbnailOfVideo(
                          videosDetails.videoDetailsItem![index - 1],
                          enablePlaying: false);
                    }
                  },
                  separatorBuilder: (context, index) =>
                      const RSizedBox(height: 20),
                  itemCount: (videosDetails.videoDetailsItem?.length ?? 0) + 1),
              loading: () => const ThineCircularProgress(),
              error: (e) {
                ToastShow.reformatToast(context, e.error);

                return const SizedBox();
              },
              orElse: () => const SizedBox());
        },
      );
    });
  }
}

class _VideoInfo extends StatelessWidget {
  const _VideoInfo();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: REdgeInsets.only(top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const _VideoTitleSubNumbersTexts(),
          const _InteractButtons(),
          Divider(color: ColorManager(context).grey1Point5),
          const _CircleNameSubscribersWidget(),
          Divider(color: ColorManager(context).grey1Point5),
          const _FirstCommentPreviewButton(),
          const RSizedBox(height: 15),
          Divider(color: ColorManager(context).grey1, height: 1, thickness: 7),
        ],
      ),
    );
  }
}

class _CircleNameSubscribersWidget extends StatelessWidget {
  const _CircleNameSubscribersWidget();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: REdgeInsets.symmetric(horizontal: 10, vertical: 2),
      child: Obx(
        () {
          final logic = Get.find<MiniVideoViewLogic>(tag: "1");
          VideoDetailsItem? videoDetails = logic.selectedVideoDetails;

          return Row(
            children: [
              CircularProfileImage(
                imageUrl: videoDetails?.getChannelProfileImageUrl() ?? "",
                radius: 17.r,
              ),
              const RSizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      videoDetails?.getChannelName() ?? "",
                      overflow: TextOverflow.ellipsis,
                      style: getMediumStyle(
                          color: ColorManager(context).black, fontSize: 15),
                    ),
                    const RSizedBox(height: 5),
                    Text(
                      "${videoDetails?.getSubscribersCount() ?? " "} subscribers",
                      overflow: TextOverflow.ellipsis,
                      style: getNormalStyle(
                          color: ColorManager(context).grey, fontSize: 13),
                    ),
                  ],
                ),
              ),
              const SubscribeButton(),
            ],
          );
        },
      ),
    );
  }
}

class _InteractButtons extends StatelessWidget {
  const _InteractButtons();

  @override
  Widget build(BuildContext context) {
    return RSizedBox(
      height: 60.h,
      child: Row(
        children: [
          const _LikeButton(),
          Padding(
            padding: REdgeInsetsDirectional.only(start: 35, end: 3, top: 15),
            child: const _DislikeButton(),
          ),
        ],
      ),
    );
  }
}

class _VideoTitleSubNumbersTexts extends StatelessWidget {
  const _VideoTitleSubNumbersTexts();

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        draggableBottomSheet(context);
      },
      child: Padding(
        padding: REdgeInsets.symmetric(horizontal: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Obx(
              () {
                final logic = Get.find<MiniVideoViewLogic>(tag: "1");
                VideoDetailsItem? videoDetails = logic.selectedVideoDetails;
                return Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        videoDetails?.getVideoTitle() ?? "",
                        overflow: TextOverflow.ellipsis,
                        maxLines: 3,
                        style: getNormalStyle(
                            color: ColorManager(context).black, fontSize: 15),
                      ),
                      const RSizedBox(height: 8),
                      Text(
                        "${videoDetails?.getVideoViewsCount()} views . ${videoDetails?.getVideoPublishedTime()} ago",
                        overflow: TextOverflow.ellipsis,
                        style: getNormalStyle(
                            color: ColorManager(context).grey7, fontSize: 13),
                      ),
                    ],
                  ),
                );
              },
            ),
            const Icon(Icons.keyboard_arrow_down_outlined),
          ],
        ),
      ),
    );
  }
}
