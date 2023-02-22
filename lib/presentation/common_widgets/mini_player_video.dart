import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:youtube/core/resources/color_manager.dart';
import 'package:youtube/core/resources/styles_manager.dart';
import 'package:youtube/data/models/common/base_comment_snippet/sub_comment_snippet.dart';
import 'package:youtube/data/models/videos_details/video_details_extension.dart';
import 'package:youtube/data/models/videos_details/videos_details.dart';
import 'package:youtube/presentation/common_widgets/circular_profile_image.dart';
import 'package:youtube/presentation/cubit/single_video/single_video_cubit.dart';
import 'package:youtube/presentation/custom_packages/custom_mini_player/custom_mini_player.dart';
import 'package:youtube/presentation/custom_packages/pod_player/src/controllers/pod_player_controller.dart';
import 'package:youtube/presentation/custom_packages/pod_player/src/models/play_video_from.dart';
import 'package:youtube/presentation/custom_packages/pod_player/src/pod_player.dart';
import 'package:youtube/presentation/pages/home/logic/home_page_logic.dart';
import 'package:youtube/presentation/common_widgets/subscribe_button.dart';

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
    double height = mediaQuery.size.height - 70.h;
    final ValueNotifier<double> playerExpandProgress = ValueNotifier(height);

    return SafeArea(
      child: CustomMiniPlayer(
        valueNotifier: playerExpandProgress,
        minHeight: minHeight,
        maxHeight: height,
        onDismissed: () {
          _miniVideoViewLogic.selectedVideoDetails = null;
        },
        builder: (height, percentage) {
          _miniVideoViewLogic.percentageOFMiniPage = percentage;
          _miniVideoViewLogic.heightOFMiniPage = height;

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
  const NextVideosSuggestions({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        itemBuilder: (context, index) {
          // if (index == 0) {
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
              ],
            ),
          );
          // }
          // return MovedThumbnailVideo(index);
        },
        separatorBuilder: (context, index) => const RSizedBox(height: 20),
        itemCount: 1);
  }
}

class _FirstCommentPreviewButton extends StatelessWidget {
  const _FirstCommentPreviewButton();

  @override
  Widget build(BuildContext context) {
    final miniVideoViewLogic = Get.find<MiniVideoViewLogic>(tag: "1");
    String commentCount =
        miniVideoViewLogic.selectedVideoDetails?.getVideoCommentsCount() ?? "0";
    return Padding(
      padding: REdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Comments $commentCount",
                style: getNormalStyle(
                    color: ColorManager(context).black, fontSize: 13),
              ),
              const Icon(Icons.keyboard_arrow_down_outlined),
            ],
          ),
          const RSizedBox(height: 10),
          const _FirstComment()
        ],
      ),
    );
  }
}

class _FirstComment extends StatelessWidget {
  const _FirstComment();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final miniVideoViewLogic = Get.find<MiniVideoViewLogic>(tag: "1");
      final String videoId = miniVideoViewLogic.selectedVideoDetails?.id ?? "";
      return BlocBuilder<SingleVideoCubit, SingleVideoState>(
        bloc: BlocProvider.of<SingleVideoCubit>(context)
          ..getFirstComment(videoId),
        buildWhen: (previous, current) => current.maybeWhen(orElse: () => true),
        builder: (context, state) {
          return state.maybeWhen(
              firstCommentLoaded: (firstCommentDetails) {
                if (firstCommentDetails.items?.isEmpty ?? true) {
                  return const SizedBox();
                }
                SubCommentSnippet? snippet = firstCommentDetails
                    .items?[0]?.snippet?.topLevelComment?.snippet;

                return _FirstCommentBody(snippet: snippet);
              },
              loading: () => const SizedBox(),
              orElse: () => const SizedBox());
        },
      );
    });
  }
}

class _FirstCommentBody extends StatelessWidget {
  const _FirstCommentBody({required this.snippet});

  final SubCommentSnippet? snippet;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CircularProfileImage(
            imageUrl: snippet?.authorProfileImageUrl ?? "",
            channelId: snippet?.authorChannelId?.value ?? ""),
        const RSizedBox(width: 10),
        Flexible(
          child: Text(
            snippet?.textOriginal ?? "",
            style: getNormalStyle(
                color: ColorManager(context).black, fontSize: 13),
            maxLines: 4,
            overflow: TextOverflow.ellipsis,
          ),
        )
      ],
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
      height: 53.h,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          ...List.generate(
              7,
              (index) => Padding(
                    padding: REdgeInsetsDirectional.only(
                        start: 45, end: index == 6 ? 45 : 3, top: 15),
                    child: Column(
                      children: [
                        const Icon(Icons.library_add_outlined),
                        const RSizedBox(height: 5),
                        Text(
                          "Like",
                          style: getNormalStyle(
                              color: ColorManager(context).black, fontSize: 13),
                        )
                      ],
                    ),
                  ))
        ],
      ),
    );
  }
}

class _VideoTitleSubNumbersTexts extends StatelessWidget {
  const _VideoTitleSubNumbersTexts();

  @override
  Widget build(BuildContext context) {
    return Padding(
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
    );
  }
}

class _MiniVideoView extends StatelessWidget {
  const _MiniVideoView({
    required this.height,
    required this.percentage,
  });

  final double height;
  final double percentage;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Flexible(
          child: Row(
            children: [
              _VideoOfMiniDisplay(height, percentage),
              const VideoTitleSubTitleTexts(),
              Expanded(
                flex: 1,
                child: GestureDetector(
                  child: const Icon(Icons.play_arrow),
                  onTap: () {},
                ),
              ),
              Expanded(
                flex: 1,
                child: GestureDetector(
                  child: const Icon(Icons.close),
                  onTap: () {
                    final miniVideoViewLogic =
                        Get.find<MiniVideoViewLogic>(tag: "1");
                    miniVideoViewLogic.selectedVideoDetails = null;
                  },
                ),
              ),
            ],
          ),
        ),

        /// todo
        // const LinearProgressIndicator(
        //   value: 0.4,
        //   minHeight: 2,
        //   valueColor: AlwaysStoppedAnimation<Color>(
        //     Colors.red,
        //   ),
        // ),
      ],
    );
  }
}

class _VideoOfMiniDisplay extends StatefulWidget {
  const _VideoOfMiniDisplay(this.height, this.percentage);
  final double height;
  final double percentage;

  @override
  State<_VideoOfMiniDisplay> createState() => _VideoOfMiniDisplayState();
}

class _VideoOfMiniDisplayState extends State<_VideoOfMiniDisplay> {
  final logic = Get.find<MiniVideoViewLogic>(tag: "1");
  late PodPlayerController videoController;
  String videoId = "";
  @override
  void initState() {
    super.initState();
    videoId = logic.selectedVideoDetails?.id ?? "";
    videoController = PodPlayerController(
      playVideoFrom: PlayVideoFrom.youtube('https://youtu.be/$videoId'),
    )..initialise();
  }

  @override
  void dispose() {
    super.dispose();
    videoController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Obx(
      () => Container(
        height: logic.videoOfMiniDisplayHeight(),
        width: logic.videoOfMiniDisplayWidth(screenWidth),
        color: ColorManager(context).grey1,
        child: videoId.isEmpty
            ? null
            : CustomPodVideoPlayer(
              controller: videoController,
              matchFrameAspectRatioToVideo: true,
              matchVideoAspectRatioToFrame: true,
            ),
      ),
    );
  }
}

class VideoTitleSubTitleTexts extends StatelessWidget {
  const VideoTitleSubTitleTexts({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 3,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Obx(
          () {
            final logic = Get.find<MiniVideoViewLogic>(tag: "1");
            VideoDetailsItem? videoDetails = logic.selectedVideoDetails;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Flexible(
                  child: Text(
                    videoDetails?.getVideoTitle() ?? "",
                    overflow: TextOverflow.ellipsis,
                    style: getNormalStyle(
                        color: ColorManager(context).black, fontSize: 12),
                  ),
                ),
                Flexible(
                  child: Text(
                    videoDetails?.getChannelName() ?? "",
                    overflow: TextOverflow.ellipsis,
                    style: getNormalStyle(
                        color: ColorManager(context).grey7, fontSize: 12),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
