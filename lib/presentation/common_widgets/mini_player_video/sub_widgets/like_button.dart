part of '../mini_player_video.dart';

class _LikeButton extends StatelessWidget {
  const _LikeButton();

  @override
  Widget build(BuildContext context) {
    final miniVideoViewLogic = Get.find<MiniVideoViewLogic>(tag: "1");
    VideoDetailsItem? videoDetails = miniVideoViewLogic.selectedVideoDetails;
    String videoId = videoDetails?.id ?? "";
    if (videoId.isEmpty) {
      return _LikeIconButton(videoId: videoId, videoDetails: videoDetails);
    } else {
      return BlocBuilder<SingleVideoCubit, SingleVideoState>(
        bloc: BlocProvider.of<SingleVideoCubit>(context)
          ..getVideoRating(videoId: videoId),
        buildWhen: (previous, current) =>
            previous != current && current is GetVideoRatingLoaded,
        builder: (context, state) => state.maybeWhen(
          getVideoRatingLoaded: (ratingDetails) {
            return _LikeIconButton(
              videoId: videoId,
              ratingDetails: ratingDetails,
              videoDetails: videoDetails,
            );
          },
          loading: () => const InteractionShimmerLoading(),
          error: (error) {
            ToastShow.reformatToast(context, error.error);
            return _LikeIconButton(
              videoId: videoId,
              videoDetails: videoDetails,
            );
          },
          orElse: () => _LikeIconButton(
            videoId: videoId,
            videoDetails: videoDetails,
          ),
        ),
      );
    }
  }
}

class _LikeIconButton extends StatefulWidget {
  const _LikeIconButton(
      {required this.videoId, this.ratingDetails, required this.videoDetails});
  final RatingDetails? ratingDetails;
  final String videoId;
  final VideoDetailsItem? videoDetails;
  @override
  State<_LikeIconButton> createState() => _LikeIconButtonState();
}

class _LikeIconButtonState extends State<_LikeIconButton> {
  final miniVideoViewLogic = Get.find<MiniVideoViewLogic>(tag: "1");
  String likeText = "";
  @override
  void initState() {
    super.initState();

    likeText = widget.videoDetails?.getVideoLikesCount() ?? "Like";
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: REdgeInsetsDirectional.only(start: 35, end: 3, top: 15),
      child: InkWell(
        onTap: () {
          if (widget.videoId.isNotEmpty) {
            String rating = widget.ratingDetails?.rating == "none"
                ? "none"
                : "like";
            SingleVideoCubit.get(context)
                .rateThisVideo(videoId: widget.videoId, rating: rating);

            miniVideoViewLogic.selectedVideoRating = rating;
          }
        },
        child: Obx(() => Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                miniVideoViewLogic.selectedVideoRating != "like"
                    ?const SvgIcon(IconsAssets.likeIcon)
                    :const SvgIcon(IconsAssets.likeColoredIcon),
                const RSizedBox(height: 5),
                Text(
                  likeText,
                  style: getNormalStyle(
                      color: ColorManager(context).black, fontSize: 13),
                )
              ],
            )),
      ),
    );
  }
}
