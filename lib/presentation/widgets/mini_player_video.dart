import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:miniplayer/miniplayer.dart';
import 'package:youtube/core/resources/color_manager.dart';
import 'package:youtube/core/resources/styles_manager.dart';
import 'package:youtube/presentation/pages/home/logic/home_page_logic.dart';
import 'package:youtube/presentation/widgets/subscribe_button.dart';
import 'package:youtube/presentation/widgets/moved_thumbnail_video.dart';

class MiniPlayerVideo extends StatefulWidget {
  const MiniPlayerVideo({super.key});

  @override
  State<MiniPlayerVideo> createState() => _MiniPlayerVideoState();
}

class _MiniPlayerVideoState extends State<MiniPlayerVideo> {
  double minHeight = 50.h;
  final _miniVideoViewLogic = Get.find<MiniVideoViewLogic>(tag: "1");

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    double height = mediaQuery.size.height - 70.h;

    return SafeArea(
      child: Miniplayer(
        minHeight: minHeight,
        maxHeight: height,
        onDismissed: () {
          _miniVideoViewLogic.videoIndex.value = null;
        },
        builder: (height, percentage) {
          _miniVideoViewLogic.percentageOFMiniPage.value = percentage;
          _miniVideoViewLogic.heightOFMiniPage.value = height;

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
          if (index == 0) {
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
          }
          return MovedThumbnailVideo(index);
        },
        separatorBuilder: (context, index) => const RSizedBox(height: 20),
        itemCount: 30);
  }
}

class _FirstCommentPreviewButton extends StatelessWidget {
  const _FirstCommentPreviewButton();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: REdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Comments 801",
                style: getNormalStyle(
                    color: ColorManager(context).black,
                    fontSize: 13),
              ),
              const Icon(Icons.keyboard_arrow_down_outlined),
            ],
          ),
          const RSizedBox(height: 10),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CircleAvatar(
                  radius: 13,
                  backgroundColor: ColorManager.green),
              const RSizedBox(width: 10),
              Flexible(
                child: Text(
                  "This is the comment" * 20,
                  style: getNormalStyle(
                      color: ColorManager(context).black,
                      fontSize: 13),
                  maxLines: 4,
                  overflow: TextOverflow.ellipsis,
                ),
              )
            ],
          ),
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
      child: Row(
        children: [
          CircleAvatar(radius: 17.r, backgroundColor: ColorManager.teal),
          const RSizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Ahmed Abdo Elhawary",
                  overflow: TextOverflow.ellipsis,
                  style: getMediumStyle(
                      color: ColorManager(context).black, fontSize: 15),
                ),
                const RSizedBox(height: 5),
                Text(
                  "1.88M subscribers",
                  overflow: TextOverflow.ellipsis,
                  style: getNormalStyle(
                      color: ColorManager(context).grey, fontSize: 13),
                ),
              ],
            ),
          ),
          const SubscribeButton(),
        ],
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
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "هل الايفون اصبح جهاز سئ",
                overflow: TextOverflow.ellipsis,
                maxLines: 3,
                style: getNormalStyle(
                    color: ColorManager(context).black, fontSize: 15),
              ),
              const RSizedBox(height: 8),
              Text(
                "141k view . 12d ago",
                overflow: TextOverflow.ellipsis,
                style: getNormalStyle(
                    color: ColorManager(context).grey7, fontSize: 13),
              ),
            ],
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
                    miniVideoViewLogic.videoIndex.value = null;
                    // context
                    //     .read(selectedVideoProvider)
                    //     .state = null;
                  },
                ),
              ),
            ],
          ),
        ),
        const LinearProgressIndicator(
          value: 0.4,
          minHeight: 2,
          valueColor: AlwaysStoppedAnimation<Color>(
            Colors.red,
          ),
        ),
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
  final controller = Get.find<MiniVideoViewLogic>(tag: "1");

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Obx(() => Container(
      height: controller.videoOfMiniDisplayHeight(),
      width: controller.videoOfMiniDisplayWidth(screenWidth),
      color: ColorManager.blue,
      child: Center(child: Text("${controller.videoIndex.value}")),
    )) ;
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
              child: Text(
                "هل الايفون اصبح جهاز سئ",
                overflow: TextOverflow.ellipsis,
                style: getNormalStyle(
                    color: ColorManager(context).black, fontSize: 12),
              ),
            ),
            Flexible(
              child: Text(
                "selected Video title",
                overflow: TextOverflow.ellipsis,
                style: getNormalStyle(
                    color: ColorManager(context).grey7, fontSize: 12),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
