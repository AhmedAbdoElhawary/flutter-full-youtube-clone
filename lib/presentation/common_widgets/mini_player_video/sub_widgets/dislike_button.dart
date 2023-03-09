part of '../mini_player_video.dart';

class _DislikeButton extends StatelessWidget {
  const _DislikeButton();

  @override
  Widget build(BuildContext context) {
    final miniVideoViewLogic = Get.find<MiniVideoViewLogic>(tag: "1");
    VideoDetailsItem? videoDetails = miniVideoViewLogic.selectedVideoDetails;
    String videoId = videoDetails?.id ?? "";
    if (videoId.isEmpty) {
      return _DislikeIconButton(videoId: videoId, videoDetails: videoDetails);
    } else {
      return BlocBuilder<SingleVideoCubit, SingleVideoState>(
        bloc: BlocProvider.of<SingleVideoCubit>(context)
          ..getVideoRating(videoId: videoId),
        buildWhen: (previous, current) =>
            previous != current && current is GetVideoRatingLoaded,
        builder: (context, state) => state.maybeWhen(
          getVideoRatingLoaded: (ratingDetails) {
            return _DislikeIconButton(
              videoId: videoId,
              ratingDetails: ratingDetails,
              videoDetails: videoDetails,
            );
          },
          loading: () => const SizedBox(),
          error: (error) {
            ToastShow.reformatToast(context, error.error);
            return _DislikeIconButton(
              videoId: videoId,
              videoDetails: videoDetails,
            );
          },
          orElse: () => _DislikeIconButton(
            videoId: videoId,
            videoDetails: videoDetails,
          ),
        ),
      );
    }
  }
}

class _DislikeIconButton extends StatefulWidget {
  const _DislikeIconButton(
      {required this.videoId, this.ratingDetails, required this.videoDetails});
  final RatingDetails? ratingDetails;
  final String videoId;
  final VideoDetailsItem? videoDetails;
  @override
  State<_DislikeIconButton> createState() => _DislikeIconButtonState();
}

class _DislikeIconButtonState extends State<_DislikeIconButton> {
  final miniVideoViewLogic = Get.find<MiniVideoViewLogic>(tag: "1");

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (widget.videoId.isNotEmpty) {
          String rating =
              widget.ratingDetails?.rating == "none" ? "none" : "dislike";
          SingleVideoCubit.get(context)
              .rateThisVideo(videoId: widget.videoId, rating: rating);

          miniVideoViewLogic.selectedVideoRating = rating;
        }
      },
      child: Obx(() => Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Transform.rotate(
                alignment: Alignment.center,
                angle: 3.14159,
                child: miniVideoViewLogic.selectedVideoRating != "dislike"
                    ? const SvgIcon(IconsAssets.likeIcon)
                    : const SvgIcon(IconsAssets.likeColoredIcon),
              ),
              const RSizedBox(height: 5),
              Text(
                "Dislike",
                style: getNormalStyle(
                    color: ColorManager(context).black, fontSize: 13),
              )
            ],
          )),
    );
  }
}
